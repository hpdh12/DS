#include <stdio.h>
#include "AST.h"

int main(void) {
    extern int yyparse(void);

    if(yyparse()) {
        fprintf(stderr, "Error!\n");
        exit(1);
    }
}
