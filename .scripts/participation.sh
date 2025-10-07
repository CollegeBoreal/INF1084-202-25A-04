#!/bin/sh

# --------------------------------------
#
#
#
# --------------------------------------

<<<<<<< HEAD
source ../.scripts/students.sh --source-only
=======
source .scripts/students.sh --source-only
>>>>>>> e7ca14532d1dfd370d8e3994b5211a6e8e0899a2
   
echo "# Participation au `date +"%d-%m-%Y %H:%M"`"
echo ""


echo "| Table des matières            | Description                                             |"
echo "|-------------------------------|---------------------------------------------------------|"
echo "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
echo "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

echo ""
echo "## Légende"
echo ""

echo "| Signe              | Signification                 |"
echo "|--------------------|-------------------------------|"
echo "| :heavy_check_mark: | Prêt à être corrigé           |"
echo "| :x:                | Projet inexistant             |"


echo ""
echo "## :a: Présence"
echo ""
<<<<<<< HEAD
echo "|:hash:| Boréal :id:                | README.md    | :one: | :two: | :three: | :four: |"
echo "|------|----------------------------|--------------|-------|-------|---------|--------|"

i=0
s=0

for id in "${ETUDIANTS[@]}"
do
   URL="[<image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image>](https://github.com/${IDS[${i}]})"
   FILE=${id}/README.md
   USR1=${id}/utilisateurs1.ps1; OK_USR1=":x:"
   USR2=${id}/utilisateurs2.ps1; OK_USR2=":x:"
   USR3=${id}/utilisateurs3.ps1; OK_USR3=":x:"
   USR4=${id}/utilisateurs4.ps1; OK_USR4=":x:"
   KO="| ${i} | [${id}](../${FILE}) ${URL} | :x: | :x: | :x: | :x: | :x: |"
   if [ -f "$FILE" ]; then
    ACTUAL_NAME="$(basename "$(realpath "$FILE")")"
    if [[ "$ACTUAL_NAME" == "README.md" ]]; then
        if [ -f "$USR1" ]; then
                OK_USR1=":heavy_check_mark:"
        fi
        if [ -f "$USR2" ]; then
                OK_USR2=":heavy_check_mark:"
        fi
        if [ -f "$USR3" ]; then
                OK_USR3=":heavy_check_mark:"
        fi
        if [ -f "$USR4" ]; then
                OK_USR4=":heavy_check_mark:"
        fi
        FULL_OK="| ${i} | [${id}](../${FILE}) ${URL} | :heavy_check_mark:| ${OK_USR1} | ${OK_USR2} | ${OK_USR3} | ${OK_USR4} | "
        echo ${FULL_OK}
        let "s++"
    else
       echo ${KO}
    fi
=======
echo "|:hash:| Boréal :id:                | :id:.md    | :rocket: |"
echo "|------|----------------------------|------------|----------|"

i=0
s=0 # Success

for id in "${ETUDIANTS[@]}"
do
   URL="[${IDS[${i}]}](https://github.com/${IDS[${i}]}) <image src='https://avatars0.githubusercontent.com/u/${AVATARS[$i]}?s=460&v=4' width=20 height=20></image>"
   FILE=${id}.md
   OK="| ${i} | [${id}](../${FILE}) :point_right: ${URL} | :heavy_check_mark: | :heavy_check_mark: |"
   KO_WEB="| ${i} | [${id}](../${FILE}) :point_right: ${URL} | :heavy_check_mark: | :x: |"
   KO="| ${i} | [${id}](../${FILE}) :point_right: ${URL} | :x: |"
   if [ -f "$FILE" ]; then
       if git log --format=fuller -- ${FILE} | grep Author | grep -q "noreply"; then
           echo ${KO_WEB}
       else
           echo ${OK}
           let "s++"
       fi
>>>>>>> e7ca14532d1dfd370d8e3994b5211a6e8e0899a2
   else
       echo ${KO}
   fi
   let "i++"
   COUNT="\$\\frac{${s}}{${i}}$"
   STATS=$(echo "$s*100/$i" | bc)
   SUM="$\displaystyle\sum_{i=1}^{${i}} s_i$"
<<<<<<< HEAD
 done
 
=======
done

>>>>>>> e7ca14532d1dfd370d8e3994b5211a6e8e0899a2
echo "| :abacus: | " ${COUNT} " = " ${STATS}% "|" ${SUM} = ${s} "|"
