require 'spec_helper'
require_relative '../utils/operator_machine'

describe :OperatorMachine do
  it 'should be in :not_started state when no input is supplied' do
    OperatorMachine.new.state.should == :not_started
  end

  it 'should be in :final state when the input is an operator' do
    sm = OperatorMachine.new
    sm.input('=')
    sm.state.should == :final
    sm.val.should == 'EQ'
  end

  it 'should be in :dead state when input is not an operator' do
    sm = OperatorMachine.new
    sm.input('a')
    sm.state.should == :dead
  end
end
