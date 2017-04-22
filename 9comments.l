%{
#include<stdio.h>
#include<string.h>
int count=0;
%}

%%

"/*"[-_a-zA-Z \n]+"*/"  {count++;}
"//"[^\n]+"\n"          {count++;fprintf(yyout,"\n");}

%%

int yywrap()
{

return 1;
}

int main()
{
yyin=fopen("in.txt","r");
yyout=fopen("cout.txt","w");
yylex();
printf("%d comments\n",count);
}

