require_relative 'scanner'
require_relative 'parser'
require_relative 'file_utils'

def compile
  content = FileUtils.read ARGV.first
  scanner = Scanner.new content
  parser = Parser.new scanner.tokenize
  parser.parse
end

compile
