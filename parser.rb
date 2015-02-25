class Parser
  def self.parse(token_stream)
    i = 0
    while(i < token_stream.size)
      token = token_stream[i]
      next_token = token_stream[i+1]

      if print?(token)
        print_string next_token if string?(next_token)
        print_expression next_token if expression?(next_token)
        print_number next_token if number?(next_token)
        i += 2
      else
        i += 1
      end
    end
  end

  def self.print_string(token)
    p token[7..-1]
  end

  def self.print_expression(token)
    p token[4..-1]
  end

  def self.print_number(token)
    p token[4..-1]
  end

  def self.print?(token)
    token.upcase == "PRINT"
  end

  def self.string?(token)
    token.start_with?("STRING:")
  end

  def self.expression?(token)
    token.start_with?("EXP:")
  end

  def self.number?(token)
    token.start_with?("NUM:")
  end
end
