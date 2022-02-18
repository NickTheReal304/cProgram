#Declear /bin/bash
#!/bin/bash

#Read the file by the preflix style
array=($(ls | grep "^$2"))

#i: Integer type, take the number from the array index read in
declare -i numberOfRecordFiles=${#array[@]}

#Read the variable from the file, $1 = e.g big6.dat
while read -r p1 p2 || [ -n "$p1" ]; do
    #Assign the values to the array, sc: Short-form bc: full-form
    scTeam+=($p1)
    bcTeam+=($p2)
done < $1

#i: Integer type, take the number from the array index read in
declare -i NumberOfTeams=${#scTeam[@]}

echo Mini-league with $NumberOfTeams teams
printf '%s\n' "Rank Team G W D L Point GF GA GD"

#Declare those empty array for storing the info from match records
homeTeam=()
awayTeam=()
homeMark=()
awayMark=()

#For loop
for ((i=0; i<$numberOfRecordFiles; i++)); do
    #read the variable of those match records
    while read -r hT hM aT aM || [ -n "$aM" ]; do
      #Assgin the value into it
      homeTeam+=($hT)
      awayTeam+=($aT)
      homeMark+=($hM)
      awayMark+=($aM)
    done < ${array[$i]}
done

#i: Integer type, take the number of total records exist from the array index read in
declare -i records=${#homeTeam[@]}

for ((j=0; j<$NumberOfTeams; j++));do

  #Set the instance varables to store the record of each match for each teams  
  let game=0
  let win=0
  let point=0
  let lose=0
  let draw=0
  let goalFor=0
  let goalAgainst=0
  
  for ((k=0; k<$records; k++)); do
      #----------
      #In case, the choose team equal to home Team, then computation the match data
      if [ "${scTeam[$j]}" == "${homeTeam[$k]}" ]; then
        ((game++))
        ((goalFor+=$((${homeMark[$k]})))) #(()) -> is to to arithmetic; inside ((${homeMark[@]})) is to fetch the value insides the variable 
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
      #In case, the choose team equal to home Team, then computation the match data
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
  #create an associated array (~2d array)
  #a1=(1,1,1)
  #a2=(2,2,2)
  #a3=(3,3,3) ... etc 
  eval "declare -a a$j=( $(for m in {0}; do echo ${bcTeam[j]} $game $win $draw $lose $point $goalFor $goalAgainst $goalDifference; done) )"
done

for ((n=0; n<$NumberOfTeams; n++)); do 
  #Since it is an associated array; first use an address pointed to the related array
  var=a$n[@]
  #fetch the values from the related array
  echo ${!var} 
#Doing the sorting by selected the col-6, which team point
done | (sort -rn -k6 | nl) #'nl' is use for assgin 1,2,3... to the sorted record 