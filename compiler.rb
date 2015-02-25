require_relative 'scanner'
require_relative 'parser'
require_relative 'file_utils'

content = FileUtils.read ARGV.first
tokens = Scanner.tokenize content
Parser.parse tokens
