function [selection_frequences,selection_alphabet] = selection(frequences,alphabet)
selection_frequences=frequences(frequences>0)
selection_alphabet=alphabet(frequences>0)

