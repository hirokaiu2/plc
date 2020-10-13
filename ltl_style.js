Blockly.Blocks['universality'] = {
  init: function() {
    this.appendValueInput("p")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField("is always true");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(120);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['existence'] = {
  init: function() {
    this.appendValueInput("p")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField("becomes true, repeatedly");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(120);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['response'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("If");
    this.appendValueInput("p")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField("is true then");
    this.appendValueInput("q")
        .setCheck("Boolean");
    this.appendDummyInput()
        .appendField("becomes true, repeatedly");
    this.setInputsInline(true);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(120);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['properties'] = {
  init: function() {
    this.appendDummyInput()
        .appendField("Properties");
    this.appendStatementInput("ps")
        .setCheck(null);
    this.setColour(150);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};