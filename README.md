roomba-bot
==========

# Description

This bot roams on the table(5x5) following the given commands
   
Note: This bot does not clean your room but enjoy!

# Instruction


```
$ docker build . -t roomba-bot
$ docker run -it roomba-bot
```

or 
```
docker-compose run roomba
```

Once you the container started, type your commands and enter Ctrl-D to finish

```
(Type your command)
...
Ctrl-D
```
**The positions by REPORT are printed after hitting Ctrl-D.**
	
## Test

To run test simply run rspec:
```
$ rspec
```
## Ruby

ruby-2.7

## Report a bug

Email to kitieng@yahoo.com
