#!/bin/bash

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $script_dir/../

function run_sudo() {
	local command=$1
	local password=$2
	$script_dir/sudo.exp $command $password >/dev/null 2>&1
}

function init() {
	local is_exist_ansible=$(which ansible >/dev/null 2>&1)
	local is_exist_brew=$(which brew >/dev/null 2>&1)
	local is_exist_pip=$(which pip >/dev/null 2>&1)

	[ $is_exist_brew -ne 0 ] && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	[ $is_exist_pip -ne 0 ] && run_sudo "easy_install pip" $password
	[ $ansible_status -eq 0 ] && run_sudo "pip install ansible" $password
}

echo -n 'SUDO Password :'
read -s password
echo ""
read -p "personal or work? : " stage

run_sudo "xcodebuild -license accept" $password

$script_dir/run_playbook.exp $stage $password
