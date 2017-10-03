#!/bin/bash
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $script_dir/../

echo 'SUDO Password : '
read -s password
read -p "personal or work? : " stage

which brew >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Not found brew"
	echo "Install brew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

which pip >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Not found pip"
	echo "Install pip"
	expect -c "
	set timeout 5
	spawn sudo easy_install pip
	expect \"Password:\"
	send \"${password}\n\"
	expect \"$\"
	exit 0
	"
fi

which ansible >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Not found ansible"
	echo "Install ansible"
	pip install ansible
	expect -c "
	set timeout 5
	spawn sudo pip install ansible
	expect \"Password:\"
	send \"${password}\n\"
	expect \"$\"
	exit 0
	"
fi

expect -c "
set timeout 600
spawn ansible-playbook -i inventories/${stage} --ask-become-pass main.yml
expect \"SUDO password:\"
send \"${password}\n\"
expect \"$\"
"
