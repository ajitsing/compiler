require_relative 'keyword_machine'
require_relative 'string_machine'
require_relative 'number_machine'

class TokenFactory
  def initialize
    keyword_machine = KeywordMachine.new('print')
    string_machine = StringMachine.new
    number_machine = NumberMachine.new

    @machines = [keyword_machine, string_machine, number_machine]
  end

  def raw_data(data)
    @machines.each do |machine|
      machine.input data
    end
    self
  end

  def get_token
    machine = machine_in_final_state

    if machine.is_a? KeywordMachine
      Token.new(machine.val)
    elsif machine.is_a? StringMachine
      Token.new('STRING:' + machine.val)
    elsif machine.is_a? NumberMachine
      Token.new('NUM:' + machine.val)
    end
  end

  def machine_states
    @machines.each { |m| p m, m.state }
  end

  def reset_machines
    @machines.each { |m| m.reset_state }
  end

  def any_machine_in_final_state?
    !machine_in_final_state.nil?
  end

  private
  def machine_in_final_state
    @machines.select { |machine| machine.in_final_state? }.first
  end
end
