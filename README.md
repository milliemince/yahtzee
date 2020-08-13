## Using Markov Chains and Probabilistic Modeling to Play Yahtzee

Hello! Over the summer, I have been experimenting with Markov Chains to calculate Yahtzee probabilities as well as coded a program that strategically plays Yahtzee using these probabilities. The important files are outlined below. Please start by reading ```Using_Markov_Chains_And_Probabilistic_Modeling_To_Play_Yahtzee.pdf``` which can be accessed by clicking the blue "PDF rendering" text below. Then, you can use the blue "View in GitHub" button in the upper right-hand corner to access all of the files in my repository. There, you can find ```yahtzee5.jl```.

### Desciption of Files

```
markov-chain-yahtzee.tex
```

LaTex file describing how Markov Chain transition matrix probabilities were calculated as well as the payoff/probability model used to determine the optimal move. Closes with a full turn example that outlines how code in "yahtzee5.jl" will determine and act on the optimal move.



```
Using_Markov_Chains_And_Probabilistic_Modeling_To_Play_Yahtzee.pdf
```

[PDF rendering](https://drive.google.com/file/d/1Y5hUx9HHLH6KYypKV3E5pVbmhkAhsKf0/view?usp=sharing) of ```markov-chain-yahtzee.tex```. This document is very important in understanding how Markov Chains function in this analysis as well as the fundamentals of the Yahtzee strategy.



```
yahtzee5.jl
```
Written in Julia, executes strategy described in ```Using_Markov_Chains_And_Probabilistic_Modeling_To_Play_Yahtzee.pdf```

