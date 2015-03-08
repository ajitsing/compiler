require 'spec_helper'
require_relative '../utils/variable_machine'

describe :VariableMachine do
  it 'should be in :not_started state when no input is supplied' do
    VariableMachine.new.state.should == :not_started
  end

  it 'should be in :final state when the inputs are being supplied' do
    sm = VariableMachine.new
    sm.input('n').input('a').input('m').input('e')
    sm.state.should == :final
  end

  it 'should return the captured variable' do
    sm = VariableMachine.new
    sm.input('n').input('a').input('m').input('e').val.should == 'VAR:name'
  end

  it 'should be in :dead state when input is a space' do
    sm = VariableMachine.new
    sm.input('v').input('a').input(' ')
    sm.state.should == :dead
  end
end
