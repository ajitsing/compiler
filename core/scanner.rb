require_relative 'token'

class Scanner
  TOKENS = {
    :PRINT => "PRINT",
    :STRING => "STRING:",
    :SPACE => " ",
    :NEW_LINE => "\n",
    :DOUBLE_QUOTE => "\"",
    :NUMBER => "[0-9]",
    :VAR => "VAR",
    :EQ => "="
  }

  def self.tokenize(source)
    tokens = []
    token = string = var = expression = ""
    quote_started = var_started = is_exper = false

    source.each_char do |char|
      token += char

      if [TOKENS[:SPACE], TOKENS[:NEW_LINE]].include? token
        token = ""
      elsif TOKENS[:NEW_LINE].eql?(char)
        if !expression.empty?
          if is_exper
            tokens.push Token.new("EXP:" + expression)
            is_exper = false
          else
            tokens.push Token.new("NUM:" + expression)
          end
          expression = token = ""
        end
      elsif token.upcase.eql? TOKENS[:PRINT]
        tokens.push Token.new(TOKENS[:PRINT])
        token = ""
      elsif char == TOKENS[:DOUBLE_QUOTE]
        if !quote_started
          quote_started = true
          token = ""
        else
          quote_started = false
          tokens.push Token.new(TOKENS[:STRING] + string)
          string = ""
          token = ""
        end
      elsif token.upcase.eql? TOKENS[:VAR] and !quote_started
        var_started = true
        token = ""
      elsif var_started and !char.eql?(TOKENS[:SPACE])
        if !char.eql?(TOKENS[:EQ])
          var = token
        else
          tokens.push Token.new("VAR:"+var)
          tokens.push Token.new("EQ")
          var = ""
          var_started = false
          token = ""
        end
      elsif is_num(char)
        expression += char
      elsif is_mathematical_operator(char)
        expression += char
        is_exper = true
      elsif quote_started
        string = token
      end
    end

    tokens
  end

  def self.is_num(char)
    !Regexp.new(TOKENS[:NUMBER]).match(char).nil?
  end

  def self.is_mathematical_operator(char)
    ["+", "-", "*", "/", "%"].include? char
  end
end
