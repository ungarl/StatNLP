

num_guesses_correct = function(guess_vec){
	sum(guess_vec == answers) / n_q
}

score_guesses_control_for_guesses = function(guess_vec){
	prop_corr = num_guesses_correct(guess_vec)
	prop_chance = n_q * (1 / num_choices) / n_q
	(prop_corr - prop_chance) / (1 - prop_chance)
}


