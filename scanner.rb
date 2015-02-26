require_relative 'token'

class Scanner
  TOKENS = {
    :PRINT => "PRINT",
    :STRING => "STRING:",
    :SPACE => " ",
    :NEW_LINE => "\n",
    :DOUBLE_QUOTE => "\"",
    :NUMBER => "[0-9]"
  }

  def self.tokenize(source)
    tokens = []
    token = string = expression = ""
    state = is_exper = false

    source.each_char do |char|
      token += char

      if [TOKENS[:SPACE], TOKENS[:NEW_LINE]].include? token
        token = ""
      elsif TOKENS[:NEW_LINE].eql?(char) and !expression.empty?
        if is_exper
          tokens.push Token.new("EXP:" + expression)
          is_exper = false
        else
          tokens.push Token.new("NUM:" + expression)
        end
        expression = token = ""
      elsif token.upcase.eql? TOKENS[:PRINT]
        tokens.push Token.new(token)
        token = ""
      elsif char == TOKENS[:DOUBLE_QUOTE]
        if !state
          state = true
          token = ""
        else
          state = false
          tokens.push Token.new(TOKENS[:STRING] + string)
          string = ""
          token = ""
        end
      elsif is_num(char)
        expression += char
      elsif is_mathematical_operator(char)
        expression += char
        is_exper = true
      elsif state
        string = token
      end
    end

    p tokens
  end

  def self.is_num(char)
    !Regexp.new(TOKENS[:NUMBER]).match(char).nil?
  end

  def self.is_mathematical_operator(char)
    ["+", "-", "*", "/", "%"].include? char
  end
end
