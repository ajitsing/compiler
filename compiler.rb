require_relative 'core/scanner'
require_relative 'core/parser'
require_relative 'utils/file_utils'

class Compiler
  def self.compile(file="")
    content = FileUtil.read ARGV.first || file
    tokens = Scanner.tokenize content
    Parser.parse tokens
  end
end

#Compiler.compile #uncomment while compiling file
