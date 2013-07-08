require 'treetop'

Treetop.load('my_grammar')
parser = MyGrammarParser.new

puts parser.parse('hello chomsky')
puts parser.parse('nice world')
puts parser.parse('hello world')
