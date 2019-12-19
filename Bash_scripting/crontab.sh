#! /bin/bash

# 	Authors: Davide Pollicino (40401270) , Taylor Courtney (40398643) , Simone Piazzini (40212394) 
# 	Date: 07/11/12 
#
#	Summary : script that emulate the crontab command, allowing the user to add a crontab job, remove it, edit it, diplay the crontab jobs or remove all the crontab jobs.
#	As extra functionality, we thought about to provide to the user, the opportunity to see directly the documentation of the crontab command provided by the man command. 
#	



# Validate function will take first argument from user's input and range for hour as second and third argument
Validate() {
	if [ -z "$1" ] ; then
		return 0
	elif [ $1 -eq -1 ] ; then
		return 1
	elif [ $1 -gt $2 ] && [ $1 -lt $3 ] ; then
		return 1
	else
		return 0
	fi
}

ACTION="0"
	echo "Welcome to the Mycrontab application"
	echo "Indicate the number linked to a specific command"
while [ $ACTION != "7" ] 
do
    echo
	#Show the menu 
	echo "List of crontab commands: "
	echo " 1 - Display jobs"
	echo " 2 - Insert a job"
	echo " 3 - Edit a job"
	echo " 4 - Remove a job"
	echo " 5 - Delete all jobs"
	echo " 6 - Study the documentation for the contrab command"
	echo " 7 - Exit"
	echo
	read -p  " Command: " ACTION
	echo
	case $ACTION in 
    	1)
			#Check if the file is not empty 
			if [ -s crontab ]; then
				echo " * * * * * command to be executed "
				echo " - - - - - "
				echo " | | | | | "
				echo " | | | | ----- Day of week (0 - 7) (Sunday=0 or 7) "
				echo " | | | ------- Month (1 - 12)"
				echo " | | --------- Day of month (1 - 31) "
				echo " | ----------- Hour (0 - 23) "
				echo " ------------- Minute (0 - 59) "
				echo 
				echo "Jobs:"
				sed '=' crontab | sed 'N; s/\n/) /'
				
			else
				echo "Actually there are no cron jobs , add more using the command 2"
			fi
        	;;
    	2)
			echo "Enter -1 to repeat a command for all occurances (*), for example, entering -1 for the hour of occurance would have the command repeat every hour."
			
			CRONTABVALID=0
			#Validation of the Minute
			while [ $CRONTABVALID -ne 1 ] ;
			do
				read -p "Minute (0-59): " MINUTE
				Validate "$MINUTE" -1 60
				CRONTABVALID=$?
				if [ $MINUTE -eq -1 ] ; then
					MINUTE=*
				elif [ $CRONTABVALID -ne 1 ] ; then
					echo "Minute INVALID"
				fi
			done
			CRONTABVALID=0
			#Validation of the Hour
			while [ $CRONTABVALID -ne 1 ] ;
			do
				read -p "Hour (0-23): " HOUR
				Validate "$HOUR" -1 24
				CRONTABVALID=$?
				if [ $HOUR -eq -1 ] ; then
					HOUR=*
				elif [ $CRONTABVALID -ne 1 ] ; then
					echo "Hour INVALID"
				fi
			done
			CRONTABVALID=0
			#Validation of the Day of the week 
			while [ $CRONTABVALID -ne 1 ] ;
			do
				read -p "Day of the month (1-31): " DAYOFMONTH
				Validate "$DAYOFMONTH" 0 32
				CRONTABVALID=$?
				if [ $DAYOFMONTH -eq -1 ] ; then
					DAYOFMONTH=*
				elif [ $CRONTABVALID -ne 1 ] ; then
					echo "Day of the month INVALID"
				fi
			done
			CRONTABVALID=0
			#Validation of the Month
			while [ $CRONTABVALID -ne 1 ] ;
			do
				read -p "Month (1-12): " MONTH
				Validate "$MONTH" 0 13
				CRONTABVALID=$?
				if [ $MONTH -eq -1 ] ; then
					MONTH=*
				elif  [ $CRONTABVALID -ne 1 ] ; then
					echo "Month INVALID"
				fi
			done
			CRONTABVALID=0
			#Validation of the Day of the weel 
			while [ $CRONTABVALID -ne 1 ] ;
			do
				read -p "Day of the week (0-7) (Sunday = 0 or 7): " DAYOFWEEK
				Validate "$DAYOFWEEK" -1 8
				CRONTABVALID=$?
				if [ $DAYOFWEEK -eq -1 ] ; then
					DAYOFWEEK=*
				elif  [ $CRONTABVALID -ne 1 ] ; then
					echo "Day of the week INVALID"
				fi
			done
			CRONTABVALID=0
			#Validation of the command to execute - Positionated at the end of the Crontab job 
			while [ $CRONTABVALID -ne 1 ] ;
			do
				read -p "Command: " ACTIONTOEXECUTE
				if [ -z "$ACTIONTOEXECUTE" ] ; then
					echo "Command EMPTY"
				else
					CRONTABVALID=1
				fi
			done
			COMMAND=" "
			#Store the new crontab Job in the crontab File 
			COMMAND="${MINUTE} ${HOUR} ${DAYOFMONTH} ${MONTH} ${DAYOFWEEK} ${ACTIONTOEXECUTE}"
			echo "${COMMAND}" >> crontab	
			;;
    	3)
				echo "Each crontab job has been identified with a number followed by the command."
				echo 
				#Add an Unique index to all the lines of the file 
				sed '=' crontab | sed 'N; s/\n/) /'
				echo
				#Get the number of lines present in the file
				numberoflines=$(sed -n '$=' crontab)

				line_to_remove=0
				
				#Check if the line to edit exist or not, eventually it will print out an Error Message 
				read -p "Enter the number of the crontab job you want to edit: " line_to_remove
				if [ "$line_to_remove" -le "$numberoflines" ]; then
				

				#Get the content of the cron Job to remove 
				COMMAND=$(sed "${line_to_remove}q" < crontab)
				
				#reads user's input and splits it into an array of var
				IFS=' ' read -r -a array <<< "$COMMAND"
				
				MINUTE=${array[0]}
				HOUR=${array[1]}
				DAYOFMONTH=${array[2]}
				MONTH=${array[3]}
				DAYOFWEEK=${array[4]}
				ACTIONTOEXECUTE=${array[5]}
				
				echo " "
				echo "Which of the following would you like to edit?:"
				echo " 1 - Minute"
				echo " 2 - Hour"
				echo " 3 - Day of the month"
				echo " 4 - Month"
				echo " 5 - Day of the week"
				echo " 6 - Command"
				echo " 7 - Cancel edit"
				echo " "
				#Read which part of the crontab job the user would like to modify. If 7 is typed, the application will came back to the main menu 
				read -p "Edit option: " OPTION
				echo " "

				CRONTABVALID=0
				EDITED=0
				case $OPTION in
	
					1)
						# Validation of the Minute
						while [ $CRONTABVALID -ne 1 ] ;
						do
							read -p "Minute (0-59): " MINUTE
							Validate "$MINUTE" -1 60
							CRONTABVALID=$?
							if [ $MINUTE -eq -1 ] ; then
								MINUTE=*
							elif [ $CRONTABVALID -ne 1 ] ; then
								echo "Minute INVALID"
							fi
						done
						EDITED=1
						;;
					2)
						#Validation of the Hour
						while [ $CRONTABVALID -ne 1 ] ;
						do
							read -p "Hour (0-23): " HOUR
							Validate "$HOUR" -1 24
							CRONTABVALID=$?
							#Check if the value inserted is -1 and eventually assign "*" to the variable 
							if [ $HOUR -eq -1 ] ; then
								HOUR=*
							elif [ $CRONTABVALID -ne 1 ] ; then
								echo "Hour INVALID"
							fi
						done
						EDITED=1
						;;
					3)
						#Validation of the Day of the month
						while [ $CRONTABVALID -ne 1 ] ;
						do
							read -p "Day of the month (1-31): " DAYOFMONTH
							Validate "$DAYOFMONTH" 0 32
							CRONTABVALID=$?
\							#Check if the value inserted is -1 and eventually assign "*" to the variable 
							if [ $DAYOFMONTH -eq -1 ] ; then
								DAYOFMONTH=*
							elif [ $CRONTABVALID -ne 1 ] ; then
								echo "Day of the month INVALID"
							fi
						done
						EDITED=1
						;;
					4)

						#Validation of the  month 
						while [ $CRONTABVALID -ne 1 ] ;
						do
							read -p "Month (1-12): " MONTH
							Validate "$MONTH" 0 13
							CRONTABVALID=$?
							 #Check if the value inserted is -1 and eventually assign "*" to the variable 
							if [ $MONTH -eq -1 ] ; then
								MONTH=*
							elif  [ $CRONTABVALID -ne 1 ] ; then
								echo "Month INVALID"
							fi
						done
						EDITED=1
						;;
					5)
						#Validation of the day of the week 
						while [ $CRONTABVALID -ne 1 ] ;
						do
							read -p "Day of the week (0-7) (Sunday = 0 or 7): " DAYOFWEEK
							Validate "$DAYOFWEEK" -1 8
							CRONTABVALID=$?
							   #Check if the value inserted is -1 and eventually assign "*" to the variable 
							if [ $DAYOFWEEK -eq -1 ] ; then
								DAYOFWEEK=*
							elif  [ $CRONTABVALID -ne 1 ] ; then
								echo "Day of the week INVALID"
							fi
						done
						EDITED=1
						;;
					6)
						#Validation of the command to execute 
						while [ $CRONTABVALID -ne 1 ] ;
						do
							read -p "Command: " ACTIONTOEXECUTE
							if [ -z "$ACTIONTOEXECUTE" ] ; then
								echo "Command EMPTY"
							else
								CRONTABVALID=1
							fi
						done
						EDITED=1
						;;
					7)
						echo "Edit CANCELLED"
						return 
						;;
					*)
						#Error message 
						echo "Option INVALID"
						;;
					
				esac

				if  [ $EDITED -eq 1 ] ; then
					COMMANDEDITED=" "
					#Store the new edidte job in a COMMANEDITED variable 
					COMMANDEDITED="${MINUTE} ${HOUR} ${DAYOFMONTH} ${MONTH} ${DAYOFWEEK} ${ACTIONTOEXECUTE}"

					#Execute a replace in place of the line to remove using a temporary file 
					sed "${line_to_remove}d" crontab > file.temp && mv file.temp crontab
					echo "Job successfully deleted"
					#Print the new crontab Job in the crontab file 
					echo "${COMMANDEDITED}" >> crontab
					fi
					
				else 
					echo "the Row does not exist"
				fi
			
			;;
    	4)
			echo "Each crontab job has been identified with a number followed by the command."
			echo
			#Assign an unique index to the lines of the index 
			sed '=' crontab | sed 'N; s/\n/) /'
			echo
			read -p "Please type the number of the line you removed: " NOLINE
			sed "${NOLINE}d" crontab > file.temp && mv file.temp crontab
			echo "Job successfully deleted"
        	;;
    	5)  
			#Check if the file is not empty 
			if [ -s crontab ]; then
				#Remove the content of the crontab file 
				eval " > crontab "
				echo "Crontab jobs removed"
			else
				echo "Crontab file already empty"
			fi
        	;;
    	6) 
			#Show the manual about the crontab command 
        	eval "man crontab"
        	;;
        7)
			#Stop execution of the script
            echo "Application closed"
			exit 0
        	;;
    	*)
			#Error message printed if the action choosen is not in the menu
        	echo "Command INVALID"
        	;;
	esac

done 

exit 0



