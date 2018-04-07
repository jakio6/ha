# clearning 
## bit by bit
## learn git and vim also
## and learn english>.<
### file
* fputc:the first arguement have to be a char or a number
### gdb 
* gcc -g make it able to debug
* gcc -o output as certain filename
##### ingdb
* l	list 10 line
* b	set breakpoint
* r	run
* p	show value of variable
* n	step next
* s	step in
* c	to next breakpoint
* watch set watchpoint
* info show info
### git 
* git push -f forced push
### makefile
#### seemed to be a powerful tool
``` makefile
OBJS= s1 s2	variable
t: $(OBJS) s3 ..	t:object u want s123..things needed to generate t	 command :how to
<tab>command	use $@ here for t and other $..
s1:.. ..
<tab>command
s2:.. ..
<tab>command
.PHONY		do the follows unconditionally	
clean:.. ..
<tab>command
```
```
A=$(B)
B=$(C)
or 
B:=C
A:=C
```
* -C dir	 find makefiles from certain dir
* -f file	 use file as makefile?
* -i		 ignore faults generated while make
* -I		 include
* -n		 print but not execute
* -s 		 Do not show commands
* -w		 if path changed ,show Current path
* -p		 show what ..
