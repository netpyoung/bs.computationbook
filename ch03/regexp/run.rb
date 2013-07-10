require_relative 'repeat'
require_relative 'choose'
require_relative 'concatenate'
require_relative 'literal'
require_relative 'empty'

require_relative '../fa/fa_rule'
require_relative '../fa/nfa_rulebook'
require_relative '../fa/nfa_simulation'


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

# puts Empty.new.matches?('a')
# puts Literal.new('a').matches?('a')

pat0 = Concatenate.new(Literal.new('a'), Literal.new('b'))
# puts pat0
# puts pat0.matches?('a')
# puts pat0.matches?('ab')
# puts pat0.matches?('abc')

pat1 = Concatenate.new(Literal.new('a'),
                       Concatenate.new(Literal.new('b'), Literal.new('c')))
# puts pat1
# puts pat1.matches?('a')
# puts pat1.matches?('ab')
# puts pat1.matches?('abc')

pat2 = Choose.new(Literal.new('a'), Literal.new('b'))
# puts pat2
# puts pat2.matches?('a')
# puts pat2.matches?('b')
# puts pat2.matches?('c')

pat3 = Repeat.new(Literal.new('a'))
# puts pat3
# puts pat3.matches?('')
# puts pat3.matches?('a')
# puts pat3.matches?('aaaa')
# puts pat3.matches?('b')

pat4 = Repeat.new(
                  Concatenate.new(
                                  Literal.new('a'),
                                  Choose.new(Empty.new, Literal.new('b'))
                                  )
                  )
# puts pat4
# puts pat4.matches?('')
# puts pat4.matches?('a')
# puts pat4.matches?('ab')
# puts pat4.matches?('aba')
# puts pat4.matches?('abab')
# puts pat4.matches?('abaab')
# puts pat4.matches?('abba')


# =====================================================
require 'treetop'

class Treetop::Runtime::SyntaxNode
    def to_s
        "#{self.inspect}"
    end
end

Treetop.load('pattern')

parse_tree = PatternParser.new.parse('(a(|b))*')
# pat5 = parse_tree.to_ast
# puts pat5
# puts pat5.matches?('abaab')
# puts pat5.matches?('abba')


rule0 = NFARulebook.new([
                         FARule.new(1, 'a', 1), FARule.new(1, 'a', 2), FARule.new(1, nil, 2),
                         FARule.new(2, 'b', 3),
                         FARule.new(3, 'b', 1), FARule.new(3, nil, 2)
                         ])

nd0 = NFADesign.new(1, [3], rule0)

# puts nd0.to_nfa.current_states
# puts nd0.to_nfa(Set[2]).current_states
# puts nd0.to_nfa(Set[3]).current_states

nfa0 = nd0.to_nfa(Set[2, 3])
nfa0.read_character('b')
puts nfa0.current_states


sim0 = NFASimulation.new(nd0)
puts sim0.next_state(Set[1, 2], 'a')
puts sim0.next_state(Set[1, 2], 'b')
puts sim0.next_state(Set[3, 2], 'b')
puts sim0.next_state(Set[1, 3, 2], 'b')
puts sim0.next_state(Set[1, 3, 2], 'a')
