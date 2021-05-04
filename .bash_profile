# /etc/skel/.bash_profile

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

export HISTSIZE=1000
export LD_LIBRARY_PATH+="/usr/local/lib"

path="${HOME}/.config/scripts"
echo $PATH | grep $path >& /dev/null

if [ $? -ne 0 ]
then
        export PATH+=":$path"
fi

unset path
