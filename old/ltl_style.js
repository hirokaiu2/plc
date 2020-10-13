Blockly.Blocks['ltl'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("LTL:");
    this.appendValueInput("p")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["is true","t"], ["is false","f"]]), "tf");
    this.appendValueInput("qr")
        .setCheck("ltl_sub");
    this.setInputsInline(true);
    this.setPreviousStatement(true, "ltl");
    this.setNextStatement(true, "ltl");
    this.setColour(20);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['between'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Between");
    this.appendValueInput("q")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField("and");
    this.appendValueInput("r")
        .setCheck("Boolean");
    this.setInputsInline(true);
    this.setOutput(true, "ltl_sub");
    this.setColour(20);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['before_after'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["Before","b"], ["After","a"]]), "ba");
    this.appendValueInput("q")
        .setCheck("Boolean");
    this.setInputsInline(true);
    this.setOutput(true, "ltl_sub");
    this.setColour(20);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['after_until'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("After");
    this.appendValueInput("q")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField("until");
    this.appendValueInput("r")
        .setCheck("Boolean");
    this.setInputsInline(true);
    this.setOutput(true, "ltl_sub");
    this.setColour(20);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['ltl_spec'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("LTL specifications:");
    this.appendStatementInput("ltl")
        .setCheck("ltl");
    this.setColour(20);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['globally'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Globally");
    this.setOutput(true, "ltl_sub");
    this.setColour(20);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};