#!/bin/sh

show_message() {
cat << EOF
$1
EOF
}

show_message "This is a script that works using the pomodoro's study method.
This will run a 'timer' for 25 minutes and when it finishes, the
only thing you need to do is answer either 'y' or 'n' depending on
whether you want to continue studying or not.
"

read -p "When you're ready to start, press Enter."

reply='c'
while [[ $reply == 'y' || $reply == 'Y' || $reply == 'c' || $reply == 'C' ]]
do
        if [[ $reply == 'c' || $reply == 'C' ]]
        then
                clear
        fi

        timer --minutes=25
        show_message "
Now it's time to take a break. Relax your mind for 10 minutes.
And when it had finished answer 'y' or 'n' to the question below,
depending on whether you want to continue studying or not.

Available options:
c = continue clearing the screen
y = only continue
n or any other letter = exit
"

        read -p "Do you want to continue studying? " reply
        echo
done
