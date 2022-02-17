#!/bin/bash
#
#
#
#
#
# Created by Cristian Sánchez.
# February 14, 2022.
#
clear 

bold=$(tput bold)
normal=$(tput sgr0)

echo " ------------------ ----------------"
echo "|    ${bold}GAUM SCRIPT${normal}   |  vers:  1.3    |"
echo "\`------------------´'-----------------------"
echo "1. Users management                         \\"
echo " \`- c)      Create a new user               |"
echo " '- cm)     Create new users massively      |"
echo " '- d)      Delete user                     |"
echo " '- dm)     Delete users massively          |"
echo " \`- l)      List of users                   |"
echo "-------------------------------------------- "
echo "2. Group management                         |"
echo " \`- n)      Create new a group              |"
echo " '- add)    Add user to group               |"
echo " '- am)     Add user massively to group     |"
echo " '- ex)     Exclude user                    |"
echo " '- r)      Remove group                    |"
echo " \`- lg)      List a group                   /"
echo "--------------------------------------------"
read -p " press x to quit|              ${bold}command:${normal} " eleccion
echo "--------------------------------------------"
case $eleccion in

	x)
		exit 1;;
	c)
		clear	
		
		echo " ------------------"
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"	
		echo "\`------------------´'----------------´"
		echo ""
		echo "  >  Username for the user: "
		echo "     '"
		read -p "     $: " user_name

		sudo useradd $user_name
		sudo passwd $user_name

		RESULT=$?
		
		echo "-------------------------------------"

		if [ $RESULT -eq 0 ]; then
			echo "User ${bold}$user_name${normal} successfully created"

		else 
			sudo deluser $user_name
			echo "User ${bold}$user_name${normal} not created"
		fi
		
		echo ""
		echo "-------------------------------------"
		echo ""

		read -p "Press any key to go back to menu: " none
		sh gaum.sh;;

	cm)
		clear
		echo " ------------------"
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"
		echo "\`------------------´'----------------´"
		echo ""
		echo "  >  All users username identifier"
		echo "     example: user1, user2"
		echo "     '"
		read -p "     $: " user_name
		echo ""
		echo "---------------------------------------"
		echo ""
		echo "  >  Number of new users"
		echo "     '"
		read -p "     $: " cuantity
		
		clear
		echo "---------------------------------------"

		for i in $(seq 1 $cuantity)
		do
			sudo useradd $user_name$i

			if [ $i -eq 1 ]; then
				echo "Creating users:"
				echo ""
				printf "["
			fi	

			printf "#"
			sleep .1

			if [ $i -eq $cuantity ]; then
				printf "]"
			fi	
		done
		echo ""
		echo "${bold}Users created successfully.${normal}"
		echo ""
		echo "Now, before login, use passwd to change user password."
		echo ""
		echo "---------------------------------------"
		echo ""
		read -p "Press any key to go back to menu: " none
		sh gaum.sh;;

	d)
		clear
		echo " ------------------"	
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"	
		echo "\`------------------´'----------------"
		echo ""	
		echo "  >  Username for deletion" 
		echo "     '"
		read -p "     $: " username
		
		sudo deluser $username
		
		
		echo "---------------------------------------"
		echo ""
		read -p "Press any key to go back to menu: " none
		sh gaum.sh;;
	dm)	
		clear

		echo " ------------------"	
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"	
		echo "\`------------------´'----------------"
		echo ""
		echo "  >  Username identifier for deletion"
		echo "     '"
		read -p "     $: " username
		echo ""
		echo "---------------------------------------"
		echo ""
		echo "  >  Deletion start point"
		echo "     example: 23, 12"
		echo "     '"
		read -p "     $: " startp
		echo ""
		echo "---------------------------------------"
		echo ""
		echo " >  Deletion end point"
		echo "    '"
		read -p "     $: " endp
		
		clear
		echo "---------------------------------------"
	
		for i in $(seq $startp $endp)
		do
			sudo deluser $username$i >> log.txt

			if [ $i -eq 1 ]; then
				echo "Deleting users:"
				echo ""
				printf "["
			fi

			printf "#"
			sleep .1

			if [ $i -eq $endp ]; then
				printf "]"	
			fi

		done	

		echo ""
		echo ""	
		echo "---------------------------------------"
		echo ""
		read -p "Want to check log file (y/n): " election
		echo ""
		echo "---------------------------------------"

		if [ $election = "y" ]; then
			more log.txt
			echo ""
			echo "---------------------------------------"
			read -p "Press any key to go back to menu: " back
			/dev/null > log.txt 
			sh gaum.sh
		else
            /dev/null > log.txt
			sh gaum.sh
		fi;;

	l)
		clear 
		echo "---------------------------------------"
		echo ""
		echo "USERS: "
		echo ""
		cat /etc/passwd

		echo ""
		echo "---------------------------------------"
		echo ""
		read -p "Press any key to go back to menu: " back
		sh gaum.sh;;
	n)
		clear
		echo " ------------------"	
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"	
		echo "\`------------------´'----------------"
		echo ""
		echo "  >  Name for the group creation"
		echo "     '"
		read -p "     $: " groupname
		echo "---------------------------------------"

		sudo addgroup $groupname

		if [ $? -eq 0 ]; then
			echo ""
			echo "${bold}Group $groupname created successfully${normal}"
			echo ""
		else 
			echo ""
			echo "${bold}Group $groupname not created${normal}"
			echo ""	
		fi


		echo "---------------------------------------"
		echo ""

		read -p "Press any key to go back to menu: " input
		sh gaum.sh;;
	
	add) 
		clear
		echo " ------------------"	
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"		
		echo "\`------------------´'----------------"
		echo ""
		echo "  >  Username of the user to add"
		echo "     '"
		read -p "     $: " username
		echo ""
		echo "---------------------------------------"
		echo ""
		echo "  >  Group name to add $username"
		echo "     '"
		read -p "     $: " groupname	
		echo ""
		echo "---------------------------------------"
		echo ""

		sudo usermod -a -G $groupname $username  
		
		if [ $? -eq 0 ]; then
			echo "${bold}User $username added successfully${normal}"
		else 
			echo "${bold}User $username not added: "
		fi

		echo ""
		echo "---------------------------------------"
		echo ""
		
		read -p "Press any key to go back to menu: " back
		sh gaum.sh;;

	am)

		clear

		echo " ------------------"	
		echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"		
		echo "\`------------------´'----------------"
		echo ""
		echo "  >  Common users identifier"
		echo "     '"
		read -p "     $: " usernames
		echo ""
		echo "---------------------------------------"
		echo ""
		echo "  >  Users list start point"
		echo "     '"
		read -p "     $: " startp
		echo ""
		echo "---------------------------------------"
		echo ""
		echo "  >  Users list end point"
		echo "     '"
		read -p "     $: " endp
		echo ""
		echo "---------------------------------------"
		echo ""
		echo "  >  Name of the group to add users to"
		echo "     '"
		read -p "     $: " group
		echo ""
		echo "---------------------------------------"


		clear
		
		echo ""
		for i in $(seq $startp $endp)
		do
			sudo usermod -a -G $group $usernames$i

			if [ $i -eq $startp ]; then
				echo "Adding users to the group:"
				echo ""
				printf "["
			fi

			printf "#"
			sleep .1

			if [ $i -eq $endp ]; then
				printf "]"
			fi
		done

		echo ""
		echo "---------------------------------------"
		echo ""
		echo ""

		read -p "Press any key to go back to menu: " back
		sh gaum.sh;;

	ex)
        clear

        echo " ------------------"
        echo "|    ${bold}GAUM SCRIPT${normal}   | ${bold}Ctrl + c${normal} to quit|"
        echo "\`------------------´'----------------"
        echo ""
        echo "  >  Common identifier of users to exlcude"
        echo "     '"
        read -p "     $: " usernames
        echo ""
        echo "-------------------------------------------"
        echo ""
        echo "  >  Users list start point"
        echo "     '"
        read -p "     $: " startp
        echo ""
        echo "-------------------------------------------"
        echo ""
        echo "  >  Users list end point"
        echo "     '"
        read -p "     $: " endp
        echo ""
        echo "-------------------------------------------"
        echo ""
        echo "  >  Group name to exclude users"
        echo "     '"
        read -p "     $: " group
        echo ""
        echo "-------------------------------------------"


        clear
        
        echo ""
        for i in $(seq $startp $endp)
        do
            sudo gpasswd -d $usernames$i $group >> log.txt

            if [ $i -eq $startp ]; then
                echo "Adding users to the group:"
                echo ""
                printf "["
            fi

            printf "#"
            sleep .1

            if [ $i -eq $endp ]; then
                printf "]"
            fi
        done

        echo ""
        echo "---------------------------------------"
        echo ""
        read -p "Want to check log file (y/n): " election
        echo ""
        echo "---------------------------------------"

        if [ $election = "y" ]; then
            more log.txt
            echo ""
            echo "---------------------------------------"
            read -p "Press any key to go back to menu: " back
            /dev/null > log.txt
            sh gaum.sh
        else
            /dev/null > log.txt
            sh gaum.sh
        fi;;

	r)
        echo ""
		read -p "Group name to delete: " group

		sudo groupdel $group

		echo "${bold}Group deleted successfully${normal}"
        echo ""
        echo "---------------------------------------"
        echo ""

        read -p "Press any key to go back to menu: " back
        sh gaum.sh;;
        
    lg)
        clear
        
        echo "---------------------------------------"
        echo ""
        echo "GROUPS: "
        echo ""
        cat /etc/group

        echo ""
        echo "---------------------------------------"
        echo ""
        read -p "Press any key to go back to menu: " back
        sh gaum.sh;;

esac
