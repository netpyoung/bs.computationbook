require_relative 'repeat'
require_relative 'choose'
require_relative 'concatenate'
require_relative 'literal'
require_relative 'empty'


p0 = Repeat.new(
                Choose.new(
                            Concatenate.new(Literal.new('a'),
                                            Literal.new('b')),
                            Literal.new('a')
                            )
                )
# puts p0

nd0 = Empty.new.to_nfa_design
# puts nd0.accepts?('')
# puts nd0.accepts?('a')

nd1 = Literal.new('a').to_nfa_design
# puts nd1.accepts?('')
# puts nd1.accepts?('a')

puts Empty.new.matches?('a')
puts Literal.new('a').matches?('a')

# require 'treetop'

# class Treetop::Runtime::SyntaxNode
#     def to_s
#         "#{self.inspect}"
#     end
# end

# Treetop.load('pattern')

# # parse_tree = PatternParser.new.parse('(a(|b))*')
# # puts parse_tree.to_ast

# parse_tree = PatternParser.new.parse('(a(|b))*')
# puts parse_tree.to_ast
