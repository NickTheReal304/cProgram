#Declear /bin/bash
#!/bin/bash

#Reminder: Please this file to be excutuble ... e.g: chomd 


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

previuosHostTeam=()

#Checking the anomely
for ((j=0; j<$records; j++)); do 
  #Declare some variable use for the checking
  let counter=0
  let hostCounter=0
  let alreadyExist=0
  #array type
  currentHostTeam=()
  currentAwayTeam=()
  #Assign the numberOfPreviousTeams with the index of array
  declare -i numberOfPerviousTeams=${#previuosHostTeam[@]}
  
  #Check if the record alreadyExist or not
  for ((i=0; i<$numberOfPerviousTeams; i++)); do
    #If the record alreadt exist, the boolean will be 0 --> 1
    if [[ "${previuosHostTeam[$i]}" == "${homeTeam[$j]}" ]]; then
      alreadyExist=1
    elif [ "${previuosHostTeam[$i]}" == "${awayTeam[$j]}" ]; then
      alreadyExist=1
    fi
  done

  #If exist, then end the loop for the repeat record
  if [ "${alreadyExist}" == 1 ]; then
    break
  fi
  
  #If not exist then loop through the record again... and find the same record...
  for ((k=0; k<$records; k++)); do
    if [[ "${homeTeam[$j]}" == "${homeTeam[$k]}" && "${awayTeam[$j]}" == "${awayTeam[$k]}" ]]; then
      ((hostCounter++))
      currentHomeTeam=${homeTeam[$k]}
      currentAwayTeam=${awayTeam[$k]}
      ((counter++))
    elif [ "${homeTeam[$j]}" == "${awayTeam[$k]}" -a "${awayTeam[$j]}" == "${homeTeam[$k]}" ]; then
      ((counter++))
    fi
  done
  #If the record really indicated that the record already bigger then three.. then print it
  if [ "${counter}" \> 2 ]; then
    echo according to the records, there are duplicate records ...
    printf '%s %s\n' "${homeTeam[j]} is ready playing ${currentAwayTeam} three times"
    previuosHostTeam+=(${homeTeam[j]})
  fi

done
