# Gaum - Groups And User Management

Gaum is a shell script created in bash 5.1. The purpose of this script is to facilitate the creation of groups and users in Linux. Also how to add these last ones to different groups in a massive way.

#### Latest version is:

![GitHub release (latest by date)](https://img.shields.io/github/v/release/sanchez-cristian/Gaum-script?label=Script%20version&logo=GNU%20Bash&logoColor=%23fff)

## Clone Project

To clone the repository go to the directory where you want to save the repository and type the following command in the terminal. 

`git clone https://github.com/sanchez-cristian/Gaum-script` 

## How to Run

Use is so easy, whether you have downloaded the repository or cloned it you will see `gaum.sh` file on it. This file is a Bash Shell Script this means that you can run it using `sh` command. As below.

`sh gaum.sh`

To improve the usability of Gaum it's recommended to run the sh command being sudoer user.

`sudo sh gaum.sh`

## Commands

> **NOTE:** It's important to know that Gaum doesn't handle created user password because it can be a security breach. But that can be solved 
using `passwd` command. As in the example below. 
`sudo passwd example_username`

`c` \- Create new User.

`cm` \- Create new users in bulk by getting user_example1, user_example2... You will set users cuantity.

`d` \- Delete a User.

`dm` \- Delete users in bulk. It's needed all users identifier. As in the example of the `cm` command, we have 'user_example' which is the common identifier.

`l` \- List of users.

`n` \- Create new group.

`add` \- Add user to a group.

`am` \- Massively add users to a group.

`ex` \- Massively exclude users to a group. This means massively removing users from a group.

`r` \- Remove a group

`lg` \- List of groups
