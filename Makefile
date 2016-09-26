all:
	lex zotac.l
	bison -d zotac.y
	gcc lex.yy.c zotac.tab.c main.c -o zotac -lfl -g
clean:
	rm -rf lex.yy.c zotac.tab.c zotac.tab.h zotac 
