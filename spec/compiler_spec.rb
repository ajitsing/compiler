require_relative 'spec_helper'
require_relative '../compiler'

describe 'compiler' do
  it 'should print the given string' do
    source_code = <<-LG
      print "Hello World"
      print "Hello World!"
    LG

    FileUtil.stub(:read).with('some_file').and_return(source_code)
    output = Compiler.compile 'some_file'

    output.include?("Hello World").should be_truthy
    output.include?("Hello World!").should be_truthy
  end

  #it 'should evaluate expression' do
    #source_code = <<-LG
      #print 10 + 20
      #print 2 * 4
      #print 2 - 4
      #print 10 / 5
    #LG

    #FileUtil.stub(:read).with('some_file').and_return(source_code)
    #output = Compiler.compile 'some_file'

    #output.include?(30).should be_truthy
    #output.include?(8).should be_truthy
    #output.include?(-2).should be_truthy
    #output.include?(2).should be_truthy
  #end

  it 'should print numbers' do
    source_code = <<-LG
      print 10
    LG

    FileUtil.stub(:read).with('some_file').and_return(source_code)
    output = Compiler.compile 'some_file'

    output.include?(10).should be_truthy
  end

  #it 'should handle variables' do
    #source_code = <<-LG
      #var name = "Ajit Singh"
      #var age = 20
      #var marks = 80 + 60 + 70
      #print $name
      #print $age
      #print $marks
    #LG
    #FileUtil.stub(:read).with('some_file').and_return(source_code)
    #output = Compiler.compile 'some_file'

    #output.include?("Ajit Singh").should be_truthy
    #output.include?(20).should be_truthy
    #output.include?(210).should be_truthy
  #end
end
