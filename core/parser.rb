require_relative 'token'

class Parser
  SYMBOLS = {}

  def self.parse(tokens)
    i = 0
    while(i < tokens.size)
      token = tokens[i]
      next_token = tokens[i+1]

      if token.print?
        next_token.expression? ? print_expression(next_token) : p(next_token.val)
        i += 2
      else
        add_variable(token, tokens[i+2]) if variable?(token, next_token, tokens[i+2])
        i += 1
      end
    end
    p SYMBOLS
  end

  def self.add_variable(var_tok, val_tok)
    SYMBOLS[var_tok.var_name] = val_tok.val
  end

  def self.variable?(token1, token2, token3)
    token1.raw[0..2] + " " + token2.raw + " " + token3.raw[0..5] ==  "VAR EQ STRING" or
    token1.raw[0..2] + " " + token2.raw + " " + token3.raw[0..2] ==  "VAR EQ NUM" or
    token1.raw[0..2] + " " + token2.raw + " " + token3.raw[0..2] ==  "VAR EQ EXP"
  end

  def self.print_expression(token)
    p eval_expression(token.expression)
  end

  def self.eval_expression(expr)
    eval expr
  end
end
