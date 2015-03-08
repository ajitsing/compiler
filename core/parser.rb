require_relative 'token'

class Parser
  SYMBOLS = {}
  OUT = []

  def self.parse(tokens)
    i = 0
    while(i < tokens.size)
      token = tokens[i]
      next_token = tokens[i+1]

      if token.print?
        if next_token.expression?
          print_expression(next_token)
        elsif next_token.variable?
          print_variable(next_token)
        else
          OUT.push(p(next_token.val))
        end
        i += 2
      elsif variable?(token, next_token, tokens[i+2])
        add_variable(token, tokens[i+2])
        i += 3
      else
        i += 1
      end
    end
    p SYMBOLS
    OUT
  end

  def self.print_variable(token)
    OUT.push p(SYMBOLS[token.variable_name])
  end

  def self.add_variable(var_tok, val_tok)
    if val_tok.expression?
      SYMBOLS[var_tok.var_name] = eval_expression(val_tok.val)
    else
      SYMBOLS[var_tok.var_name] = val_tok.val
    end
  end

  def self.variable?(token1, token2, token3)
    token1.raw[0..2] + " " + token2.raw + " " + token3.raw[0..5] ==  "VAR EQ STRING" or
    token1.raw[0..2] + " " + token2.raw + " " + token3.raw[0..2] ==  "VAR EQ NUM" or
    token1.raw[0..2] + " " + token2.raw + " " + token3.raw[0..2] ==  "VAR EQ EXP"
  end

  def self.print_expression(token)
    OUT.push p(eval_expression(token.expression))
  end

  def self.eval_expression(expr)
    eval expr
  end
end
