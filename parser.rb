class Parser
  def self.parse(token_stream)
    i = 0
    while(i < token_stream.size)
      if token_stream[i].upcase == "PRINT" and token_stream[i+1].start_with?("STRING:")
        p token_stream[i+1][7..-1]
        i += 2
      else
        i += 1
      end
    end
  end
end
