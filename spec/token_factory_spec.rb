require 'spec_helper'
require_relative '../utils/token_factory'

describe :TokenFactory do
  it 'should return :print token' do
    factory = TokenFactory.new
    factory.raw_data('p').raw_data('r').raw_data('i').raw_data('n').raw_data('t')
    factory.get_token.inspect.should == 'print'
  end

  it 'should return string value when the token is string' do
    factory = TokenFactory.new
    factory.raw_data("\"").raw_data('c').raw_data('o').raw_data('o').raw_data('l').raw_data("\"")
    factory.get_token.inspect.should == 'STRING:cool'
  end

  it 'should return number when the token is a number' do
    factory = TokenFactory.new
    factory.raw_data("2").raw_data("1")
    factory.get_token.inspect.should == 'NUM:21'
  end
end
