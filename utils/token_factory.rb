require_relative 'keyword_machine'
require_relative 'variable_machine'
require_relative 'string_machine'
require_relative 'number_machine'
require_relative 'operator_machine'
require_relative 'expression_machine'

class TokenFactory
  def initialize
    print_key = KeywordMachine.new('print')
    var_key = KeywordMachine.new('var')
    variable_machine = VariableMachine.new
    string_machine = StringMachine.new
    number_machine = NumberMachine.new
    expression_machine = ExpressionMachine.new
    operator_machine = OperatorMachine.new

    @machines = [print_key, var_key, string_machine, number_machine, expression_machine, variable_machine, operator_machine]
  end

  def raw_data(data)
    @machines.each do |machine|
      machine.input data
    end
    self
  end

  def get_token
    machine = machine_in_final_state
    Token.new(machine.val)
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
    running = @machines.select { |machine| machine.running? }

    key_machine = machines.select {|m| m.is_a? KeywordMachine}.first
    string_machine = machines.select {|m| m.is_a? StringMachine}.first
    expression_machine = machines.select {|m| m.is_a? ExpressionMachine}.first
    variable_machine = machines.select {|m| m.is_a? VariableMachine}.first
    operator_machine = machines.select {|m| m.is_a? OperatorMachine}.first

    #priority of machines
    if !key_machine.nil?
      key_machine
    elsif !string_machine.nil?
      string_machine
    elsif !expression_machine.nil?
      expression_machine
    elsif !operator_machine.nil?
      operator_machine
    elsif !variable_machine.nil? and running.empty?
      variable_machine
    end
  end
end
