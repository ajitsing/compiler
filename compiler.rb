require_relative 'core/scanner'
require_relative 'core/parser'
require_relative 'utils/file_utils'

content = FileUtils.read ARGV.first
tokens = Scanner.tokenize content
Parser.parse tokens
