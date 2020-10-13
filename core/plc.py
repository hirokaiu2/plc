from enum import IntEnum
import openpyxl
import os

in_sigs = {}
out_sigs = {}
#inout_sigs = {}

# retrieve input/output signals from excel sheet
def readTimingDiagramXls(filePath):
    num_of_signals = 0

    book = openpyxl.load_workbook(filePath)
    sheet = book["Sheet1"]
    
    row = 0
    for cell in sheet['A']:
        row += 1
        if cell.value == None:
            continue

        sigType = ""
        sigName = ""
        sig = []
        
        for sigCell in sheet[row]:
            if (sigCell.col_idx == 1):
                sigType = sigCell.value
            elif (sigCell.col_idx == 2):
                sigName = sigCell.value
            else:
                top = sigCell.border.top.border_style
                bottom = sigCell.border.bottom.border_style
                if (top == "medium"):
                    sig.append(1)
                elif (bottom == "medium"):
                    sig.append(0)
            
        if sigType == "in":
            in_sigs[sigName] = sig
        elif sigType == "out":
            out_sigs[sigName] = sig
        #elif sigType == "inout":
        #    inout_sigs[sigName] = sig

    for sigName in in_sigs:
        sigs = in_sigs[sigName]
        num_of_signals =len(sigs)
        break
        
    return num_of_signals

def readTimingDiagramWd(fileName):
  num_of_signals = 0
  
  f = open(fileName, "r")
  for line in f:
    line = line.replace("{", "")
    line = line.replace("},", "")
    line = line.replace("\"", "")
    line = line.replace("'", "")
    line = line.replace(" ", "")
    if line.startswith("name:"):
      tokens = line.split(",")
      sigType = tokens[0].split(":")[1]
      sigName = tokens[0].split(":")[2]
      sigText = tokens[1].split(":")[1]
      sigList = []
      mode = "l"
      for sig in sigText:
        if sig == "l":
          sigList.append(0)
          mode = "l"
        elif sig == "h":
          sigList.append(1)
          mode = "h"
        elif sig == ".":
          if mode == "l":
            sigList.append(0)
          elif mode == "h":
            sigList.append(1)
      if sigType == "in":
        in_sigs[sigName] = sigList
      elif sigType == "out":
        out_sigs[sigName] = sigList
  f.close()
  
  for sigName in in_sigs:
      sigs = in_sigs[sigName]
      num_of_signals =len(sigs)
      break
  
  ### For debug
  #for ins in in_sigs:
  #  print(ins + "->" + str(in_sigs[ins]))
  #for outs in out_sigs:
  #  print(outs + "->" + str(out_sigs[outs]))
  #print(num_of_signals)
  
  return num_of_signals

# definition of combination of input/output signals
class SigComb():
    def __init__(self):
        self.in_sigs = {}
        self.out_sigs = {}
    def add_ins(self, key, value):
        self.in_sigs[key] = value
    def add_outs(self, key, value):
        self.out_sigs[key] = value

# definition of state of signals
class Change(IntEnum):
    NONE = 0
    UP   = 1
    DOWN = 2

# 0->1:UP, 1->0:DOWN, 0->0/1->1:NONE
def detectValueChange(signal, t):
    if t == 0:
        return Change.NONE
    elif signal[t] != signal[t - 1]:
        if signal[t] == 1:
            return Change.UP
        else:
            return Change.DOWN
    else:
        return Change.NONE

# create combination of input/output signals
def createSigCombList(num_of_signals):
    sig_comb_list = []

    # (1) loop for timing chart
    for t in range(num_of_signals):
        changed = False
        sc = SigComb()
        
        # (1-1) retrieve all output signals those values are changed
        for outs in out_sigs:
            ch = detectValueChange(out_sigs[outs], t)

            if (ch == Change.UP or ch == Change.DOWN):
                changed = True
                sc.add_outs(outs, (out_sigs[outs])[t])

        # (1-2) if output signals changed, retrieve all input signals
        if changed:
            for ins in in_sigs:
                sc.add_ins(ins, (in_sigs[ins])[t])
            sig_comb_list.append(sc)
            
    return sig_comb_list

# generate program from combination of input/output signals
def generateProgram(sig_comb_list):
    prog = ""
    for sc in sig_comb_list:
        # (1) generate conditions
        cond = ""
        isFirst = True
        for ins in sc.in_sigs:
            if isFirst:
                cond = "if "
                isFirst = False
            else:
                cond += " and "
            if sc.in_sigs[ins] == 1:
                cond += ins
            else:
                cond += "(not " + ins + ")"
        prog += cond + "\n"
        # (2) generate actions
        for outs in sc.out_sigs:
            if sc.out_sigs[outs] == 1:
                prog += "\tSet(" + outs + ")\n"
            else:
                prog += "\tReset(" + outs + ")\n"
            #prog += "\t" + outs + "({})".format(sc.out_sigs[outs]) + "\n"
    return prog

def generateVariables():
  vars = ""
  in_vars = ""
  out_vars = ""
  for ins in in_sigs:
    in_vars += " " + ins + " = FALSE,"
  for outs in out_sigs:
    out_vars += " " + outs + " = FALSE,"
  vars += "variables" + in_vars + "\n"
  vars += "         " + out_vars + "\n"
  vars += "          plc_state = 0, state = 0;\n\n"
  return vars

def generateInputLogic(sig_comb_list):
  inputLogic = ""
  isFirst = True
  inputLogic += "    either\n"
  for sc in sig_comb_list:
    input = ""
    if isFirst:
      isFirst = False
    else:
      input += "or "
    for ins in sc.in_sigs:
      if sc.in_sigs[ins] == 1:
        input += ins + " := TRUE; "
      else:
        input += ins + " := FALSE; "
    inputLogic += "      " + input + "\n"
  inputLogic += "    end either;\n"
  return inputLogic
  
def generateInputLogic2(num_of_signals):
  isFirst = True
  inputLogic = "    either\n"
  for i in range(num_of_signals):
    input = ""
    if isFirst:
      isFirst = False
    else:
      input += "or "
    for ins in in_sigs:
      if in_sigs[ins][i] == 1:
        input += ins + " := TRUE; "
      else:
        input += ins + " := FALSE; "
    inputLogic += "      " + input + "\n"
  inputLogic += "    end either;\n"
  return inputLogic
        
def generateOutputLogic(sig_comb_list):
  outputLogic = ""
  cond = ""
  isFirst = True
  isLast = False
  snum = 0
  for sc in sig_comb_list:
    # (1) condition part
    if isFirst:
      cond = "    if "
      isFirst = False
    else:
      cond = "    elsif "
    cond += "state = " + str(snum)
    for ins in sc.in_sigs:
      if sc.in_sigs[ins] == 1:
        cond += " /\ " + ins + " = TRUE"
      else:
        cond += " /\ " + ins + " = FALSE"
    cond += " then"
    outputLogic += cond + "\n"
    # (2) action part
    for outs in sc.out_sigs:
      if sc.out_sigs[outs] == 1:
        outputLogic += "      " + outs + " := TRUE;\n"
      else:
        outputLogic += "      " + outs + " := FALSE;\n"
    snum += 1
    if snum == len(sig_comb_list):
      snum = 0
    outputLogic += "      state := " + str(snum) + ";\n"
  outputLogic += "    end if;\n"
  return outputLogic

# generate TLA+ modeling language (PlusCal)
# LIST: sig_comb_list = {sig_comb[0], sig_comb[1], ...}
# OBJ:  sig_comb = {in_sigs, out_sigs}
# HASH: in_sigs = {in_name->sig}, out_sigs = {out_name->sig}
def generatePlusCalModel(num_of_signals, sig_comb_list):
  pc_model = ""
  pc_model += "------------------------------- MODULE plc -------------------------------\n"
  pc_model += "EXTENDS Naturals, TLC\n"
  pc_model += "\n"
  pc_model += "(* --algorithm plc\n"
  pc_model += generateVariables()
  pc_model += "fair process plc = 1\n"
  pc_model += "begin\n"
  pc_model += "PLC_LOOP:\n"
  pc_model += "while TRUE do\n"
  pc_model += "  if plc_state = 0 then\n"
  #pc_model += generateInputLogic(sig_comb_list)
  pc_model += generateInputLogic2(num_of_signals)
  pc_model += "    plc_state := 1;\n"
  pc_model += "  elsif plc_state = 1 then\n"
  pc_model += generateOutputLogic(sig_comb_list)
  pc_model += "    plc_state := 2;\n"
  pc_model += "  elsif plc_state = 2 then\n"
  for ins in in_sigs:
    pc_model += "    " + ins + " := FALSE;\n"
  pc_model += "    plc_state := 0;\n"
  pc_model += "  end if;\n"
  pc_model += "end while;\n"
  pc_model += "end process\n"
  pc_model += "\nend algorithm *)\n"
  pc_model += "DollySpec == [] ~((6_moveFw = TRUE) /\ (7_moveBw = TRUE))\n"
  pc_model += "ArmSpec == [] ~((8_pushFw = TRUE) /\ (9_pushBw = TRUE))\n"
  pc_model += "ExtSpec == [] ((0_startButton = TRUE) ~> (6_moveFw = TRUE))\n"
  pc_model += "=============================================================================\n"
  return pc_model

def generateConfig():
  config = ""
  config += "\* SPECIFICATION definition\n"
  config += "SPECIFICATION\n"
  config += "Spec\n"
  config += "\* PROPERTY definition\n"
  config += "PROPERTY\n"
  config += "DollySpec\n"
  config += "ArmSpec\n"
  config += "ExtSpec\n"
  return config

def isErrorOccured(fileName):
  isError = False
  f = open(fileName, "r")
  for line in f:
    if line.startswith("Error: "):
      isError = True
      break
  f.close()
  return isError

def extractCounterExample(fileName):
  ce = []
  oneCe = []
  isCeText = False
  f = open(fileName, "r")
  for line in f:
    if line.startswith("State "):
      isCeText = True
      oneCe = []
    elif isCeText and line.startswith("/\\"):
      line = line.strip("/\\ \n")
      oneCe.append(line)
    elif isCeText and line == "\n":
      ce.append(oneCe)
      isCeText = False
  f.close()
  return ce

def createSigList(ce):
  sigList = {}
  isFirst = True
  for oneCe in ce:
    for i in range(len(oneCe)):
      key = oneCe[i].split(" = ")[0]
      value = oneCe[i].split(" = ")[1]
      if isFirst:
        oneSigList = []
        oneSigList.append(value)
        sigList[key] = oneSigList
      else:
        sigList[key].append(value)
    isFirst = False
  return sigList

def translateToWaveDorm(sigList):
  wd = "{ signal: [\n"
  for sigName in sorted(sigList.keys()):
    wd += "  { name: \"" + sigName + "\", wave: '"
    sig = sigList[sigName]
    pre_sig = ""
    isNotBool = False
    for oneSig in sig:
      sym = "l"
      if oneSig == pre_sig:
        sym = "."
      elif oneSig == "TRUE":
        sym = "h"
      elif oneSig == "FALSE":
        sym = "l"
      else:
        sym = "4"
        isNotBool = True
      wd += sym
      pre_sig = oneSig
    wd += "'"
    if isNotBool:
      wd += ", data: '"
      pre_num = ""
      for oneSig in sig:
        if pre_num != oneSig:
          wd += str(oneSig) + " "
        pre_num = str(oneSig)
      wd += "'"
    wd += " },\n"
  wd += "  ]\n}\n"
  return wd

def visualizeCounterExample(tlcOut, wdCe):
  if isErrorOccured(tlcOut):
    ce = extractCounterExample(tlcOut)
    #for s in ce:
    #  print(s)
    sigList = createSigList(ce)
    #for sig in sigList:
    #  print(sig + ":" + str(sigList[sig]))
    wd = translateToWaveDorm(sigList)
    #print(wd)
    wdCe_file = open(wdCe, "w+")
    wdCe_file.write(wd)
    wdCe_file.close()
  else:
    wdCe_file = open(wdCe, "w+")
    wdCe_file.write("")
    wdCe_file.close()
    print("No Error")

# < main >
def main():
  # (1) Read timing diagram
  #num_of_signals = readTimingDiagramXls("TimingChart3.xlsx")
  num_of_signals = readTimingDiagramWd("core/plc.wd")
  sig_comb_list = createSigCombList(num_of_signals)
  # (2) Generate PLC program
  prog = generateProgram(sig_comb_list)
  prog_file = open("core/plc.prg", "w+")
  prog_file.write(prog)
  prog_file.close()
  # (3) Generate TLA+ model
  model = generatePlusCalModel(num_of_signals, sig_comb_list)
  model_file = open("core/plc.tla", "w+")
  model_file.write(model)
  #print(model)
  model_file.close()
  # (4) Generate TLA+ config file
  cfg = generateConfig()
  cfg_file = open("core/plc.cfg", "w+")
  cfg_file.write(cfg)
  cfg_file.close()
  # (5) Excecute TLA+ model checking
  os.system("pcal core/plc.tla")
  os.system("tlc core/plc.tla > core/plc.out")
  # (6) Visualize counter example by WaveDrom
  visualizeCounterExample("core/plc.out", "core/plc.ce")

main()
#readTimingDiagram("plc.wd")
