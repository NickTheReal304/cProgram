#Declear /bin/bash
#!/bin/bash
echo "Hello world, The process id will be show in order"

array=($(ls | grep "^$2"))

declare -i s=${#array[@]}

while read -r p1 p2; do
 #echo "p1:$p1 p2:$p2"
 scTeam+=($p1)
 bcTeam+=($p2)
done < $1

declare -i NumberOfTeams=${#scTeam[@]}

echo Mini-league with $NumberOfTeams teams
echo Rank Team G W D L Point GF GA GD

homeTeam=()
awayTeam=()
homeMark=()
awayMark=()

for ((i=0; i<$s; i++)); do
 
    while read -r hT hM aT aM; do

      homeTeam+=($hT)
      awayTeam+=($aT)
      homeMark+=($hM)
      awayMark+=($aM)

    done < ${array[$i]}

done

declare -i records=${#homeTeam[@]}
declare -p homeMark
#Note that
#The winning team will score 3 points, the losing team will score 0 point.
#If the game ends up with a draw, both teams will score 1 point. 
#Rank
for ((j=0; j<$NumberOfTeams; j++));do
  echo --------------
  #echo $j
  echo ${bcTeam[$j]}

  let win=0
  let point=0

  for ((k=0; k<$records; k++)); do
      
      if [ "${scTeam[$j]}" == "${homeTeam[$k]}" ] &&
         [ "${homeMark[$k]}" \> "${awayMark[$k]}" ]; then
          ((win++))
      elif [ "${scTeam[$j]}" == "${awayTeam[$k]}" ] &&
           [ "${awayMark[$k]}" \> "${homeMark[$k]}" ]; then
          ((win++))
      else
        echo 
      fi
  done
  echo ${bcTeam[j]} $win 
done