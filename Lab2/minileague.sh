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
declare -p bcTeam

echo Mini-league with $NumberOfTeams teams
printf '%s\n' "Rank Team G W D L Point GF GA GD"

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
#declare -p homeMark

#Note that
#The winning team will score 3 points, the losing team will score 0 point.
#If the game ends up with a draw, both teams will score 1 point. 
#Rank
#construct a matrix





for ((j=0; j<$NumberOfTeams; j++));do
  #echo --------------
  #echo $j
  #echo ${bcTeam[$j]}
  #eval "declare -a a$j=( $(for m in {0..7}; do echo 0; done) )"
  
  let game=0
  let win=0
  let point=0
  let lose=0
  let draw=0
  let goalFor=0
  let goalAgainst=0
  
  for ((k=0; k<$records; k++)); do
      #----------
      if [ "${scTeam[$j]}" == "${homeTeam[$k]}" ]; then
        ((game++))
        ((goalFor+=$((${homeMark[$k]}))))
        ((goalAgainst+=$((${awayMark[$k]}))))
        if [ "${homeMark[$k]}" \> "${awayMark[$k]}" ]; then
          ((win++))
          ((point+=3))
        elif [ "${homeMark[$k]}" == "${awayMark[$k]}" ]; then
          ((draw++))
          ((point++))
        else
          ((lose++))
        fi
      #----------
      elif [ "${scTeam[$j]}" == "${awayTeam[$k]}" ]; then
          ((game++))
          ((goalFor+=$((${awayMark[$k]}))))
          ((goalAgainst+=$((${homeMark[$k]}))))
          if [ "${awayMark[$k]}" \> "${homeMark[$k]}" ]; then
            ((win++))
            ((point+=3))
          elif [ "${awayMark[$k]}" == "${homeMark[$k]}" ]; then
            ((draw++))
            ((point++))
          else
            ((lose++))
          fi
      fi
  done
  let goalDifference=$(($goalFor - $goalAgainst))

  eval "declare -a a$j=( $(for m in {0}; do echo ${bcTeam[j]} $game $win $draw $lose $point $goalFor $goalAgainst $goalDifference; done) )"
  
done

for ((n=0; n<$NumberOfTeams; n++)); do 
  #printf '%s' "$n "
  var=a$n[@]
  echo ${!var} 
done | (sort -rn -k6 | nl)

 


