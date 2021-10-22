roomba-bot
==========

# Description

   This bot roams on the table(5x5) following the given commands
   
   Note: This bot does not clean your room but enjoy!

## Usage

	There is an executable under bin directory
	$ cd roomba-bot/bin
	$ chmod +x ./roomba_walk

	If you want to give commands from STDIN
	$ ./roomba_walk
	(Write your command)
	...
	Ctrl-D

	The positions by REPORT are printed after hitting Ctrl-D.
	
	If you want to use a file, after you create a command file
	$ cat <path_to_file> | ./roomba_walk
	
	There are some command files are provided.  To use them
	
	$ cat ../spec/fixtures/sample_commands_1.txt | ./roomba_walk
	$ cat ../spec/fixtures/sample_commands_2.txt | ./roomba_walk
	$ cat ../spec/fixtures/sample_commands_3.txt | ./roomba_walk
	$ cat ../spec/fixtures/sample_commands_4.txt | ./roomba_walk
	$ cat ../spec/fixtures/sample_commands_5.txt | ./roomba_walk
	
## Test

To run test simply run rspec:

	$ rspec

## Ruby

ruby-3.0.0 [ x86_64 ]

## Contributing

No Contribution is appreciated.

==========
