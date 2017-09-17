#?/bin/sh

type brew >/dev/null 2>&1
if [ echo $? -eq 0 ]; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
while read -p "playbook file? " playbook ; do
	while read -p "password? " password ; do
		# pip setup
		which pip >/dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "not found command pip"
			echo "install pip"
			expect -c "
			set timeout 5
			spawn sudo easy_install pip
			expect \"Password:\"
			send \"${PW}\n\"
			expect \"$\"
			exit 0
			"
		fi

		# install ansible
		which ansible >/dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "not found command ansible"
			echo "install ansible"
			pip install ansible
		fi
		expect -c "
		set timeout 600
		spawn ansible-playbook ${playbook} --ask-become-pass
		expect \"SUDO password:\"
		send \"${password}\n\"
		expect \"$\"
		"
	done
done
