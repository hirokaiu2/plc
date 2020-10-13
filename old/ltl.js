Blockly.JavaScript['ltl'] = function(block) {
  var value_p = Blockly.JavaScript.valueToCode(block, 'p', Blockly.JavaScript.ORDER_ATOMIC);
  var dropdown_tf = block.getFieldValue('tf');
  var value_qr = Blockly.JavaScript.valueToCode(block, 'qr', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '';
  if (dropdown_tf == 'f') value_p = '!' + value_p;
  var value_q = '';
  var value_r = '';
  var token = value_qr.split(',')
  var type = token[0].replace('(', '');
  if (token.length >= 2) value_q = token[1].replace(')', '');
  if (token.length == 3) value_r = token[2].replace(')', '');
  switch (type) {
    // [](!P)
    case 'globally':
      code = '[]' + value_p + '\n';
      break;
    // <>Q -> (!P U Q)
    case 'before':
      code = '<>' + value_q + ' -> (' + value_p + ' U ' + value_q + ')\n';
      break;
    // [](Q -> [](!P))
    case 'after':
      code = '[](' + value_q + ' -> []' + value_p + ')\n';
      break;
    // []((Q & !R & <>R) -> (!P U R))
    case 'between':
      code = '[]((' + value_q + ' & !' + value_r + ' & <>' + value_r + ') -> (' + value_p + ' U ' + value_r + '))\n'
      break;
    // [](Q & !R -> (!P W R))
    case 'after_until':
      code = '[]((' + value_q + ' & !' + value_r + ') -> (' + value_p + ' W ' + value_r + '))\n'
      break;        
    default:
      break;
  }
  return code;
};

Blockly.JavaScript['between'] = function(block) {
  var value_q = Blockly.JavaScript.valueToCode(block, 'q', Blockly.JavaScript.ORDER_ATOMIC);
  var value_r = Blockly.JavaScript.valueToCode(block, 'r', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = 'between,' + value_q + ',' + value_r;
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};

Blockly.JavaScript['before_after'] = function(block) {
  var dropdown_ba = block.getFieldValue('ba');
  var value_q = Blockly.JavaScript.valueToCode(block, 'q', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = '';
  if (dropdown_ba == 'b') {
    code = 'before,' + value_q;
  } else {
    code = 'after,' + value_q;
  }
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};

Blockly.JavaScript['after_until'] = function(block) {
  var value_q = Blockly.JavaScript.valueToCode(block, 'q', Blockly.JavaScript.ORDER_ATOMIC);
  var value_r = Blockly.JavaScript.valueToCode(block, 'r', Blockly.JavaScript.ORDER_ATOMIC);
  // TODO: Assemble JavaScript into code variable.
  var code = 'after_until,' + value_q + ',' + value_r;
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};

Blockly.JavaScript['ltl_spec'] = function(block) {
  var statements_ltl = Blockly.JavaScript.statementToCode(block, 'ltl');
  // TODO: Assemble JavaScript into code variable.
  var code = '...;\n';
  return code;
};

Blockly.JavaScript['globally'] = function(block) {
  // TODO: Assemble JavaScript into code variable.
  var code = 'globally,';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.JavaScript.ORDER_NONE];
};