%{
#include<stdio.h>
#include<string.h>
int f,i,j;
%}

%%

[+-]?[0-9]+	{printf("\n%s is an integer!!!",yytext);}
[+-]?[0-9]*[.][0-9]+	{f=0; for(i=0;i<yyleng;i++) 
	if(yytext[i]=='.') 
	 { j=i+1; break;}
	for(;j<yyleng;j++)
	 f++;
	printf("\n%s is a floating number of precision %d\n",yytext,f);}
[0-9a-zA-Z]+[.][0-9+-.a-zA-Z]+	{printf("\ninvalid!!!");}
[\n] 		{return 0;}

%%
int main()
{
printf("Enter a number :\n");
yylex();
}
int yywrap()
{
return 1;
}
