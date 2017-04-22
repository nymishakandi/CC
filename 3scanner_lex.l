%{
#include<stdio.h>
#include<string.h>
int t=1;
int l=1,i;
%}
hfile assert.h|complex.h|ctype.h|errno.h|fenv.h|float.h|inttypes.h|iso646.h|limits.h|locale.h|math.h|setjmp.h|signal.h|stdalign.h|stdarg.h|stdatomic.h|stdbool.h|stddef.h|stdint.h|stdio.h|stdlib.h|stdnoreturn.h|string.h|tgmath.h|threads.h|time.h|uchar.h|wchar.h|wctype.h
key auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while
file txt|h|c
format c|d|e|E|f|g|G|o|s|u|x|X
func fopen|fclose|getchar|putchar|printf|scanf|strcat|strcmp|strcpy|isdigit|isalpha|isalnum|islower|isupper|acos|asin|atan|cos|exp|fabs|sqrt|time|difftime|clock|malloc|rand|srand
type int|char|double|float
id [a-zA-Z][a-zA-Z0-9_]*
size [0-9]+
index [a-zA-Z]
s {size}|{index}|{index}"++"|{index}--|"--"{index}|"++"{index}
log &&|"||"|!
num [0-9]+
str [a-zA-Z-_]
mode r|w|a|r+|w+|a+
ffile "\""{id}"\."{file}"\""

%%

{id}"="([+-]?{num})|("""{str}""")	{printf("\n%d\t%d\t\tdefinition\t%s",l,t,yytext);t++;}
"*"[ ]?{id}			{printf("\n%d\t%d\t\tpointer\t\t%s",l,t,yytext);t++;}
"//"[^\n]+"\n"		{printf("\n%d\t%d\t\tcomment\t\t",l,t);t++;
					 for(i=2;i<yyleng-1;i++)
					 {
					   printf("%c",yytext[i]);
					 }
					 l++;
					}
"\'"[a-zA-Z0-9]"\'"	{printf("\n%d\t%d\t\tcharacter\t%s",l,t,yytext);t++;}
"\'"[a-zA-Z0-9]+"\'"	{printf("\n%d\t%d\t\tstring\t\t%s",l,t,yytext);t++;}
[;]						{printf("\n%d\t%d\t\tterminator\t%s",l,t,yytext);t++;}
{func}					{printf("\n%d\t%d\t\tfunction\t%s",l,t,yytext);t++;}
"%"{format}			{printf("\n%d\t%d\t\tformat\t\t%s",l,t,yytext);t++;}
["$&^{}(),'#] 			{printf("\n%d\t%d\t\tspecial char\t%s",l,t,yytext);t++;}
[+-=*/%]				{printf("\n%d\t%d\t\toperator\t%s",l,t,yytext);t++;}
{log}					{printf("\n%d\t%d\t\tlogical op\t%s",l,t,yytext);t++;}
{key} 					{printf("\n%d\t%d\t\tkeyword\t\t%s",l,t,yytext);t++;}
{hfile}					{printf("\n%d\t%d\t\theader file\t%s",l,t,yytext);t++;}
{id}		 				{printf("\n%d\t%d\t\tidentifier\t%s",l,t,yytext);t++;}
[a-z]+"."[a-z]+ 		{printf("\n%d\t%d\t\tidentifier\t%s",l,t,yytext);t++;}
{id}"++" 				{printf("\n%d\t%d\t\tincrementer\t%s",l,t,yytext);t++;}
{id}"--" 				{printf("\n%d\t%d\t\tdecrementer\t%s",l,t,yytext);t++;}
"=="					{printf("\n%d\t%d\t\tequality check\t%s",l,t,yytext);t++;}
"+="|"-="|"*="|"/="|"%="	{printf("\n%d\t%d\t\tcompound op\t%s",l,t,yytext);t++;}
"<="|">="|"<"|">"|"!="	{printf("\n%d\t%d\t\trelational op\t%s",l,t,yytext);t++;}
"\\"[btvrfn?0a] 		{printf("\n%d\t%d\t\tescape char\t%s",l,t,yytext);t++;}
[+-]?{num} 			{printf("\n%d\t%d\t\tnumber\t\t%s",l,t,yytext);t++;}
{id}"["{s}"]"			{printf("\n%d\t%d\t\t1-D array\t%s",l,t,yytext);t++;}
{id}"["{s}"]""["{s}"]"	{printf("\n%d\t%d\t\t2-D array\t%s",l,t,yytext);t++;}
"("{type}")"			{printf("\n%d\t%d\t\ttype cast to\t",l,t);t++;
						 for(i=1;i<yyleng-1;i++)
						 printf("%c",yytext[i]);
						}
"/*"[-_a-zA-Z \n]+"*/" 	{i=0;
					 printf("\n%d\t%d\t\tcomment\t\t",l,t);t++;
					 for(i=2;i<yyleng-2;i++)
					 {
					   if(yytext[i]=='\n')
					    yytext[i]=' ';
					   printf("%c",yytext[i]);
					 }
					}
{ffile}				{printf("\n%d\t%d\t\tspecial char\t\"",l,t);t++;
					 printf("\n%d\t%d\t\tfile\t\t",l,t);t++;
					 for(i=1;i<yyleng-1;i++)
					 printf("%c",yytext[i]);
					 printf("\n%d\t%d\t\tspecial char\t\"",l,t);t++;
					}
"printf("[a-zA-Z -_]+")"			{printf("\n%d\t%d\t\tfunction\tprintf",l,t);t++;
					 printf("\n%d\t%d\t\tspecial char\t(",l,t);t++;
					 printf("\n%d\t%d\t\toutput\t\t",l,t);t++;
					 for(i=7;i<yyleng-1;i++)
					 printf("%c",yytext[i]);
					 printf("\n%d\t%d\t\tspecial char\t)",l,t);t++;
					}
("#include<"{hfile}">")|("#include\""[a-z]+"\."{file}"\"")	{i=0;
					 printf("\n%d\t%d\t\tpreprocessor\t#",l,t);t++;
					 printf("\n%d\t%d\t\tidentifier\tinclude",l,t);t++;
					 printf("\n%d\t%d\t\tspecial char\t%c",l,t,yytext[8]);t++;
					 printf("\n%d\t%d\t\theader file\t",l,t);t++;
					 for(i=9;i<yyleng-1;i++) 
					 printf("%c",yytext[i]);
					 printf("\n%d\t%d\t\tspecial char\t%c",l,t,yytext[i]);t++;
					 }
"#define "[a-z]+" "[a-zA-Z0-9]+		{i=0;
					 printf("\n%d\t%d\t\tpreprocessor\t#",l,t);t++;
					 printf("\n%d\t%d\t\tidentifier\tdefine",l,t);t++;
					 printf("\n%d\t%d\t\tidentifier\t",l,t);t++;
					 for(i=8;yytext[i]!=' ';i++)
					 printf("%c",yytext[i]);
					 printf("\n%d\t%d\t\tconstant\t",l,t);t++;
					 i++;
					 for(;i<yyleng;i++)
					 printf("%c",yytext[i]);
					}
[\n] 				{l++;}

%%

int yywrap()
{
        return 1;
}
int main()
{
	yyin=fopen("input.c","r");
	printf("Line\tToken no\tToken name\tLexeme \n"); 
	yylex();
	printf("\n");
}
