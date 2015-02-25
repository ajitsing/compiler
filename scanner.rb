class Scanner
  def initialize(source_code)
    @source = source_code
  end

  def tokenize
    tokens = []
    token = ""
    string = ""
    state = 0

    @source.each_char do |char|
      token += char

      if [" ", "\n"].include? token
        token = ""
      elsif token.upcase == "PRINT"
        tokens.push token
        token = ""
      elsif char == "\""
        if state.zero?
          state = 1
          token = ""
        else
          state = 0
          tokens.push "STRING:" + string
          string = ""
          token = ""
        end
      elsif state == 1
        string = token
      end
    end

    tokens
  end
end
