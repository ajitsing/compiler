require_relative 'state_machine'

class VariableMachine < StateMachine
  def initialize
    super
    @var_name = ""
  end

  def input(x)
    if x.eql? ' '
      @current_state = :dead
    else
      @var_name << x
      @current_state = :final
    end
    self
  end

  def val
    "VAR:" + @var_name
  end

  def reset_state
    super
    @var_name = ""
  end
end
