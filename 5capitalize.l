%{
#include<stdio.h>
%}

%%
[0-9;!@#/:^&*><.,\\\-_ `%{}()?+=~\[\]""''$|] {}
[A-Z] {printf("%c",yytext[0]+32);}
[a-z] {printf("%c",yytext[0]-32);}
[\n]  {return 0;}

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

