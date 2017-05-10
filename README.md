# NCAA March Madness Predictor

A Matlab tool for predicting the outcome of the 2017 March Madness bracket.  It also does some other stuff.

# What does it do?

This code actually does a few things.  First, it attempts to create an optimized algorithm for maximizing accuracy of the NCAA bracket prediction.  Then, it runs through the bracket to determine the Final Four participants and the overall accuracy of the prediction.  Finally, it runs through a bunch of simulations with increasing levels of randomness, in order to gain a vague sense of how randomness affects the outcome of the bracket.

# Usage

The code is run by running the "main" script.  The main script first runs the optimization for the algorithm.  Then, it simulates the NCAA 2017 bracket using this improved algorithm.  Then, it calculates the effect of randomness on the accuracy of the bracket, and plots that.

Alternatively, you can change what algorithm to simulate matches with by changing the "match" function.  At the bottom of the function there is three initializations of `u_score` and `l_score`.  They are for using the highest seed to determine matches, using just the SRS function to determine matches, and using the custom algorithm in the "custom_algorithm" function.  Comment out the two that shouldn't be run and leave the one whose results you do want to see.  The algorithm optimization only affects the custom algorithm.

# Hopeful Improvements

One ideal improvement would be making the algorithm selection automatic, rather than requiring changing the code.  Additionally, it would be better to make the code even more modular; in this case, breaking up "main" into its three parts to be run separately as wanted.