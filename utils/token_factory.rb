require_relative 'keyword_machine'
require_relative 'string_machine'
require_relative 'number_machine'
require_relative 'expression_machine'

class TokenFactory
  def initialize
    keyword_machine = KeywordMachine.new('print')
    string_machine = StringMachine.new
    number_machine = NumberMachine.new
    expression_machine = ExpressionMachine.new

    @machines = [keyword_machine, string_machine, number_machine, expression_machine]
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
    elsif machine.is_a? ExpressionMachine
      Token.new('EXP:' + machine.val)
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

  def expression_machine_is_running?
    !@machines.select { |machine| machine.running? and machine.is_a? ExpressionMachine }.first.nil?
  end

  private
  def machine_in_final_state
    machines = @machines.select { |machine| machine.in_final_state? }
    if machines.size == 1
      machines.first
    else
      machines.select {|m| m.is_a? ExpressionMachine}.first
    end
  end
end
