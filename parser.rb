require_relative 'token'

class Parser
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
        i += 1
      end
    end
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
