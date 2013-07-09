require 'set'

require_relative 'nfa'

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)
    def accepts?(string)
        to_nfa.tap { |nfa|
            nfa.read_string(string)
        }.accepting?
    end

    def to_nfa(current_state = Set[start_state])
        NFA.new(current_state, accept_states, rulebook)
    end
end
