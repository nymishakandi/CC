%{
#include<stdio.h>
#include<string.h>
%}

%%

[0]				printf("binary or decimal");
[10]*				printf("binary");
[1-9][0-9]*			printf("decimal");
[0][0-7]+			printf("octal");
[0][xX][0-9a-fA-F]+		printf("hexadecimal");
[\n] return 0;

%%
int yywrap()
{
        return 1;
}

int main()
{ 
        printf("Enter a string\n");
        yylex();
	printf("\n");
}
