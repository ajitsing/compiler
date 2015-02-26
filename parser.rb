require_relative 'token'

class Parser
  SYMBOLS = {}

  def self.parse(tokens)
    i = 0
    while(i < tokens.size)
      token = tokens[i]
      next_token = tokens[i+1]

      if token.print?
        print_string next_token if next_token.string?
        print_expression next_token if next_token.expression?
        print_number next_token if next_token.number?
        i += 2
      else
        add_variable(token, tokens[i+2]) if variable?(token, next_token, tokens[i+2])
        i += 1
      end
    end
    p SYMBOLS
  end

  def self.add_variable(var_tok, val_tok)
    SYMBOLS[var_tok.var_name] = val_tok.string
  end

  def self.variable?(token1, token2, token3)
    token1.val[0..2] + " " + token2.val + " " + token3.val[0..5] ==  "VAR EQ STRING"
  end

  def self.print_string(token)
    p token.string
  end

  def self.print_expression(token)
    p eval_expression(token.expression)
  end

  def self.print_number(token)
    p token.number
  end

  def self.eval_expression(expr)
    eval expr
  end
end
