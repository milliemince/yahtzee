## Using Markov Chains and Probabilistic Modeling to Play Yahtzee

Hello! Over the summer, I have been experimenting with Markov Chains to calculate Yahtzee probabilities that can be used in a program that strategically plays Yahtzee. I'd love if you took a look at it! The important files are outlined below. Please start by reading ```RAISE_SYMPOSIUM_PAPER.pdf``` which can be accessed by clicking the blue "RAISE_SYMPOSIUM_PAPER.pdf" text below. Then, you can use the blue "View in GitHub" button in the upper right-hand corner to access all of the files in my repository. There, you can find ```yahtzee5.jl```.

### Description of Files

```
RAISE_SYMPOSIUM_PAPER.pdf
```

[RAISE_SYMPOSIUM_PAPER.pdf](https://drive.google.com/file/d/188iDPoL0DtVzyLyABCDPPHI3cf22WP-n/view?usp=sharing) describes the math concepts behind the strategy, such as how Markov Chain transition matrix probabilities were calculated as well as the payoff/probability model used to determine the optimal move. Towards the end of the paper, there are a full simulated turn and game examples that demonstrate how the program in "yahtzee5.jl" determines and acts on the optimal move. This document is very important in understanding how Markov Chains function in this analysis as well as the fundamentals of the Yahtzee strategy.

<br />
<br />

```
markov-chain-yahtzee.tex
```
[Download markov-chain-yahtzee.tex](https://milliemince.github.io/yahtzee/markov-chain-yahtzee.tex)

[View markov-chain-yahtzee.tex](https://github.com/milliemince/yahtzee/blob/master/markov-chain-yahtzee.tex) is the LaTex file used for ```Strategy_Description.pdf```.

<br />
<br />

```
yahtzee5.jl
```
[Download yahtzee5.jl](https://milliemince.github.io/yahtzee/yahtzee5.jl)

[View yahtzee5.jl](https://github.com/milliemince/yahtzee/blob/master/yahtzee5.jl) is written in Julia and executes the strategy described in ```Strategy_Description.pdf```
Important Functions:
* ```play()``` function simulates a game between the program and a human.
* ```play_computer()``` function simulates an entire game between two programmed players.
* ```average_score()``` simulates 50 games and returns the average score of the program. The average score is 200.3.

