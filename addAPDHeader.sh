#/usr/bin/bash

# This script adds the required header to your java files in APD545 workshop
# Your information must be to added to the script as below
#
# How to use
# - install vim with the command: sudo apt install vim -y
# - clone the repo on your machine and cd into it
# - change the permission with the command: sudo chmod u+x addAPDheader.sh
# - cd into your workshop root and run the script there

# Dependency
# - This is a bash script (which will not run on windows)
# - vim must be installed on your machine

# Warnings
# - test the script on an another directory with your dummy files before running it on your workshop
# - by using the script you agree that I hold no responsibiliy over any potential damage caused to your side

# Finally, feel free to add your contributions or suggestions under Issues

# YOU MUST SET THE VALUE FOR THESE, replace XXXX only, keep the quotes.
yourStudentID="XXXXXXXX"
yourCourse="APD545NAA"
yourSemester="4"
yourFirstName="XXXXXXXXXXX"
yourLastName="XXXXXXXXXXX"
yourSection="XXXXXXXXX"




# set the CLI color
GREEN='\033[0;32m'
RESET='\033[0m'

# variable control whether to update the header file
updated=0

# Get today's date in the desired format
today=$(date +"%b %d, %Y")

# Create the header file
cat <<EOF > header.txt
/**********************************************
Workshop # 
Course:$yourCourse - Semester $yourSemester
Last Name: $yourLastName
First Name: $yourFirstName
ID: $yourStudentID
Section: $yourSection
This assignment represents my own work in accordance with Seneca Academic Policy.
Signature $yourFirstName $yourLastName
Date: $today
**********************************************/
EOF
pathToYourHeaderFile="header.txt"

for file in $(find . -type f -name "*.java") # loop all the java files in the root dir
do

	if !(grep -q $yourStudentID $file) # if the file has no header
	then
		# update APDWorkshopHeader.txt
		if [[ $updated -eq 0 ]]
		then 
			echo -e "${GREEN}...Updating header file..."
			vim $pathToYourHeaderFile +'%s/[JFMAMJASOND][a-z][a-z] [0-3][0-9], 20[0-9][0-9]/\=strftime("%b %d, %Y")/' +wq
			echo "...Header file updated."
			updated=1
			echo
		fi
		# insert the header to file
		vim "$file" +"r $(echo $pathToYourHeaderFile)" +wq
		echo -e "-${GREEN} Header added for file $file"
		#echo
	else # if the file already has the header
		echo -e "${GREEN}- File $file already has the header."
		#echo
		vim $file +10 +'s/[JFMAMJASOND][a-z][a-z] [0-3][0-9], 20[0-9][0-9]/\=strftime("%b %d, %Y")/' +wq
		echo "	Existing header updated for $file."
		#echo
	fi

done
echo -e "${RESET}"
