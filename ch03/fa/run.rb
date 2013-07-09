require_relative 'fa_rule'

require_relative 'dfa_rulebook'
require_relative 'dfa'
require_relative 'dfa_design'

require_relative 'nfa_rulebook'
require_relative 'nfa'
require_relative 'nfa_design'


# ==================================================================
# DFA

# 1 ->a-> 2
# 2 ->a-> 2
# 3 ->a-> 2
# 1 ->b-> 2
# 2 ->b-> 3
# 3 ->b-> 3
r0 = DFARulebook.new([
                      FARule.new(1, 'a', 2), FARule.new(1, 'b', 1),
                      FARule.new(2, 'a', 2), FARule.new(2, 'b', 3),
                      FARule.new(3, 'a', 3), FARule.new(3, 'b', 3)
                     ])
# puts r0.next_state(2, 'b')

d0 = DFA.new(1, [1, 3], r0)
# puts d0.accepting?


d1 = DFA.new(1, [3], r0)              # 1 ->?????-> 3
d1.read_character('b')                # 1 ->b-> 1 ->???-> 3
3.times do d1.read_character('a') end # 1 ->a-> 2 ->a-> 2 ->???-> 3
d1.read_character('b')                # 2 ->b-> 3
#puts d1.accepting?

d2 = DFA.new(1, [3], r0)   # 1 ->?????-> 3
d2.read_string('baaab')    # 1 ->b-> 1 ->a-> 2 ->a-> 2 ->a->2 ->b-> 3
#puts d2.accepting?

dd0 = DFADesign.new(1, [3], r0)
# puts dd0.accepts?('ba')  # 1 ->b->a-> 2
# puts dd0.accepts?('ab')  # 1 ->a->b-> 3
# puts dd0.accepts?('bab') # 1 ->b->a-> 3 ->b-> 3



# ==================================================================
# NFA

r1 = NFARulebook.new([
                      FARule.new(1, 'a', 1), FARule.new(1, 'b', 1), FARule.new(1, 'b', 2),
                      FARule.new(2, 'a', 3), FARule.new(2, 'b', 3),
                      FARule.new(3, 'a', 4), FARule.new(3, 'b', 4)
                      ])

# puts r1.next_states(Set[1], 'b')
# puts r1.next_states(Set[1, 2], 'a')
# puts r1.next_states(Set[1, 3], 'b')

# puts NFA.new(Set[1], [4], r1).accepting?
# puts NFA.new(Set[1, 2, 4], [4], r1).accepting?

n0 = NFA.new(Set[1], [4], r1)
n0.read_character('b')
n0.read_character('a')
n0.read_character('b')
# puts n0.accepting?

n1 = NFA.new(Set[1], [4], r1)
n1.read_string('bbbbb')
# puts n1.accepting?

nd0 = NFADesign.new(1, [4], r1)
# puts nd0.accepts?('bab')
# puts nd0.accepts?('bbbbb')
# puts nd0.accepts?('bbabb')

r2 = NFARulebook.new([
                      FARule.new(1, nil, 2), FARule.new(1, nil, 4),
                      FARule.new(2, 'a', 3),
                      FARule.new(3, 'a', 2),
                      FARule.new(4, 'a', 5),
                      FARule.new(5, 'a', 6),
                      FARule.new(6, 'a', 4),
                      ])
# puts r2.next_states(Set[1], nil)
# puts r2.follow_free_moves(Set[1])

nd1 = NFADesign.new(1, [2, 4], r2)
# puts nd1.accepts?('')       # 1 => {2, 4}
# puts nd1.accepts?('a')      # {2, 4} => {3, 5}
# puts nd1.accepts?('aa')     # {3, 5} => {2, 6}
# puts nd1.accepts?('aaa')    # {2, 6} => {3, 4}
# puts nd1.accepts?('aaaa')   # {3, 4} => {2, 5}
# puts nd1.accepts?('aaaaa')  # {2, 5} => {3, 6}
# puts nd1.accepts?('aaaaaa') # {3, 6} => {2, 4}
