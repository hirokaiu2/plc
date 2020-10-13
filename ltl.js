Blockly.JavaScript['universality'] = function(block) {
  var value_p = Blockly.JavaScript.valueToCode(block, 'p', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  value_p = value_p.replace('==', '=');
  value_p = value_p.replace('&&', '/\\');
  value_p = value_p.replace('||', '\/');
  value_p = value_p.replace('!', '~');
  var code = '[]' + value_p + '\n';
  return code;
};

Blockly.JavaScript['existence'] = function(block) {
  var value_p = Blockly.JavaScript.valueToCode(block, 'p', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};

Blockly.JavaScript['response'] = function(block) {
  var value_p = Blockly.JavaScript.valueToCode(block, 'p', Blockly.JavaScript.ORDER_ATOMIC);
  var value_q = Blockly.JavaScript.valueToCode(block, 'q', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};

Blockly.JavaScript['properties'] = function(block) {
  var statements_ps = Blockly.JavaScript.statementToCode(block, 'ps');
  // TODO: Assemble JavaScript into code variable.
  var code = statements_ps;
  return code;
};