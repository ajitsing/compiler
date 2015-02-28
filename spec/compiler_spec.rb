require_relative 'spec_helper'
require_relative '../compiler'

describe 'compiler' do
  it 'should print the given string' do
    source_code = <<-LG
      print "Hello World"
      Print "Hello World!"
    LG

    FileUtil.stub(:read).with('some_file').and_return(source_code)
    output = Compiler.compile 'some_file'

    output.include?("Hello World").should be_truthy
    output.include?("Hello World!").should be_truthy
  end

  it 'should evaluate expression' do
    source_code = <<-LG
      print 10 + 20
      print 2 * 4
      print 2 - 4
      print 10 / 5
    LG

    FileUtil.stub(:read).with('some_file').and_return(source_code)
    output = Compiler.compile 'some_file'

    output.include?(30).should be_truthy
    output.include?(8).should be_truthy
    output.include?(-2).should be_truthy
    output.include?(2).should be_truthy
  end

  it 'should print numbers' do
    source_code = <<-LG
      print 10
    LG

    FileUtil.stub(:read).with('some_file').and_return(source_code)
    output = Compiler.compile 'some_file'

    output.include?(10).should be_truthy
  end

  it 'should handle variables' do
    source_code = <<-LG
      var name = "Ajit Singh"
      var age = 20
      var total_marks = 80 + 60
    LG

    FileUtil.stub(:read).with('some_file').and_return(source_code)
    Compiler.compile 'some_file'
  end
end
