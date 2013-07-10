class NFASimulation < Struct.new(:nfa_design)
    def next_state(state, character)
        nfa_design.to_nfa(state).tap { |nfa|
            nfa.read_character(character)
        }.current_states
    end
end
