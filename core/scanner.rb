require_relative '../utils/token_factory'

class Scanner
  def self.tokenize(source)
    tokens = []
    factory = TokenFactory.new

    source.each_char do |char|
      if (char.eql? ' ' or char.eql? "\n") and factory.any_machine_in_final_state?
        tokens.push factory.get_token
        factory.reset_machines
      else
        factory.raw_data char
      end
    end

    p tokens
  end
end
