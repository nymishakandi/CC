%{
#include<stdio.h>
int vowel=0;
int cons=0;
%}

%%
[aeiouAEIOU] {vowel++;}
[a-zA-Z] {cons++;}
[\n]  { printf("\nVowels=%d and Consonants=%d\n",vowel,cons); return 0;}
%%

int yywrap()
{
        return 1;
}
int main()
{
        printf("Enter a string\n");
        yylex();
}

