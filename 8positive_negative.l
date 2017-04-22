%{
	#include<stdio.h>
	#include<string.h>
	int i=0,ip=0,in=0,fp=0,fn=0,flag=0;
%}

%%

[+]?[0-9]+ {ip++;}
[-][0-9]+  {in++;}
[+]?[0-9]*[.][0-9.]+   { for(i=0;i<yyleng;i++)
				       {if(yytext[i]=='.')
					flag++;}
				        if(flag==1)
					fp++;
					flag=0;
				    }

[-][0-9]*[.][0-9.]+      { for(i=0;i<yyleng;i++)
				{if(yytext[i]=='.')
				flag++;}
				if(flag==1)
				fn++;
				flag=0;
			}

%%

int yywrap()
{
	printf("%d positive integers\n",ip);
	printf("%d negative integers\n",in);
	printf("%d positive fractions\n",fp);
	printf("%d negative fractions\n",fn);
	return 1;
}
int main()
{
	yyin=fopen("file.txt","r");
	yylex();
}
