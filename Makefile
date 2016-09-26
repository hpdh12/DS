all:
	lex miniC.l
	bison -d  miniC.y
	gcc lex.yy.c miniC.tab.c main.c -o miniC -lfl -g
clean:
	rm -rf lex.yy.c miniC.tab.c miniC.tab.h miniC 
