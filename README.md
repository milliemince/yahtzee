## Using Markov Chains and Probabilistic Modeling to Play Yahtzee

Hello! Over the summer, I have been experimenting with Markov Chains to calculate Yahtzee probabilities as well as coded a program that strategically plays Yahtzee using these probabilities. The important files are outlined below. Please start by reading ```Strategy_Description.pdf``` which can be accessed by clicking the blue "PDF rendering" text below. Then, you can use the blue "View in GitHub" button in the upper right-hand corner to access all of the files in my repository. There, you can find ```yahtzee5.jl```.

### Desciption of Files

```
Strategy_Description.pdf
```

[Strategy_Description.pdf](https://drive.google.com/file/d/1Y5hUx9HHLH6KYypKV3E5pVbmhkAhsKf0/view?usp=sharing) describes the math concepts behind the strategy, such as how Markov Chain transition matrix probabilities were calculated as well as the payoff/probability model used to determine the optimal move. Towards the end of ```Strategy_Description.pdf```, there is a full simulated turn example that outlines how the program in "yahtzee5.jl" determines and acts on the optimal move. This document is very important in understanding how Markov Chains function in this analysis as well as the fundamentals of the Yahtzee strategy.

<br />
<br />

```
markov-chain-yahtzee.tex
```
[markov-chain-yahtzee.tex](https://milliemince.github.io/yahtzee/markov-chain-yahtzee.tex) is the LaTex file used for ```Strategy_Description.pdf```.

<br />
<br />

```
yahtzee5.jl
```
[yahtzee5.jl](https://milliemince.github.io/yahtzee/yahtzee5.jl) is written in Julia and executes the strategy described in ```Strategy_Description.pdf```
Important Functions:
* ```play()``` function simulates a game between the program and a human.
* ```play_computer()``` function simulates an entire game between two programmed players.
* ```average_score()``` simulates 50 games and returns the average score of the program. The average score is 200.3.

