#!/usr/bin/env bash

if [ -z "$__GLOBAL_FUNCTIONS_INCLUDED" ]; then

fi

function PARAM_VALID {
	local param="$1"

	if [ -z "$param" ]; then
		return 1
	fi
	return 0
}

function PKG_INSTALLED {
	local pkg="$1"

	if ! PARAM_VALID $pkg; then
		echo "Invalid package"
		exit 1
	fi

	if dpkg -s $pkg | grep -q "installed ok installed"; then
		return 1
	fi
	return 0
}

function PKG_REQUIRE {
	local pkg="$1"

	if PKG_INSTALLED $pkg; then
		echo "Package [$pkg] already installed"
		return 0
	fi
	echo "Installing [$pkg]... "
	sudo apt-get install -y $pkg
	return 0
}

function PKG_PURGE {
	local pkg="$1"

	if ! PKG_INSTALLED $pkg; then
		echo "Package [$pkg] not installed"
		return 0
	fi
	echo "Purging [$pkg]..."
	sudo apt-get purge -y $pkg
	return 0
}


function FILE_EXISTS {
	local PATH="$1"

	if ! PARAM_VALID $PATH; then
		echo "Invalid file path"
		exit 1
	fi
	if [ ! -f $PATH ]; then
		return 1
	fi
	return 0
}