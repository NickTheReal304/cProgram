# C Program lab2

## **Objective**
Write a bash shell script called
minileague to input the scores of soccer games and draw up the league table among a few selected
teams. The script will first read in the team information from a file whose name is specified as the first
parameter, e.g. big6.dat. Each line of the file contains the short name of a team, followed by the
name of the team. Your program then reads in a sequence of files containing the scores of games on
different days or weeks, as indicated by the prefix of those files specified as the second parameter, e.g.
score2122. This concept of a mini-league is useful for some common tie-breaking rules.

|Filename       |Content                                            |
|---------------|--------------------------------------------------:|
|Top4.dat       |ARS Arsenal                                        |
|               |CHE Chelsea                                        |
|               |LIV Liverpool                                      |
|               |MUN ManchesterUnited                               |
|---------------|---------------------------------------------------|
|score21220101  |LIV 1 CHE 1                                        |
|               |MUN 1 ARS 2                                        |
|---------------|---------------------------------------------------|
|score21220102  |MUN 0 LIV 5                                        |
|               |ARS 0 CHE 2                                        |


## Output
Mini-league with 4 teams
|Rank|team              |G  |W  |D  |L  |Point |GF |GA |GD |
|----|:----------------:|:-:|:-:|:-:|:-:|:----:|:-:|:-:|:-:|
|1   |Liverpool         |2  |1  |1  |0  |4     |6  |1  |5  |
|2   |Chelsea           |2  |1  |1  |0  |4     |3  |1  |2  |
|3   |ManchesterUnited  |2  |1  |0  |1  |3     |3  |7  |-4 |
|4   |Arsenal           |2  |1  |0  |2  |2     |2  |5  |-5 |

1. run
```
./minileague.sh big.dat score2122   
```