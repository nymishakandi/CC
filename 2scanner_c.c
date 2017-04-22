#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>
char key[32][10]={"auto","break","case","char","const","continue","default","do","double","else","enum","extern","float","for","goto","if","int","long","register","return","short","signed","sizeof","static","struct","switch","typedef","union","unsigned","void","volatile","while"};
char echar[10]={'b','t','v','r','f','n','\\','?','0','a'},com[100];
int main()
{
 FILE *f;
 char c,x,y,z,temp[20],fr[5];
 int i,j,k,l=1,t=1,f1,flag,m,p;
 f=fopen("input.c","r");
 if(f)
 {
  printf("Line\tToken no\tToken name\t\tLexeme\n"); 
  while((c=getc(f))!=EOF)
  {
   j=0;
   if(isalpha(c))
   {
	flag=0;
	temp[j++]=c;c=getc(f);
	while(isalnum(c))
	{
	 temp[j++]=c;c=getc(f);
	}
	for(i=0;i<32;i++)
	{
	 if(strcmp(temp,key[i])==0)
	 {
	  flag=1;
	  break;
	 }
	}
	if(flag==1)
	{
	 printf("%d\t%d\t\tkeyword\t\t\t%s\n",l,t,temp);
	 t++;
	}
	else
	{
	 if(c=='.')
	 {
	  temp[j++]=c;
	  for(p=0;p<5;p++)
	  { fr[p]='\0'; }
	  y=getc(f);
	  while(y!='>')
	  {
	   fr[p++]=y;
	   temp[j++]=y;
	   y=getc(f);
	   if(y==';'||y=='"')	break;
	  }
	  fseek(f,-(j+10),SEEK_CUR);
	  y=getc(f);
	  fseek(f,(j+9),SEEK_CUR);
	  if(y=='#')
	  {
	   printf("%d\t%d\t\theader\t\t\t%s\n",l,t,temp);
	  }
	  else
 	  { printf("%d\t%d\t\tidentifier\t\t%s\n",l,t,temp); t++;
	  fseek(f,-1,SEEK_CUR);}
	 }
	 else
	 {
	  fseek(f,-1,SEEK_CUR);
	  printf("%d\t%d\t\tidentifier\t\t%s\n",l,t,temp);
	   t++;
	 }
	}
   }
   else if(c=='+'||c=='='||c=='-'||c=='<'||c=='>'||c=='*'||c=='/')
   {
   	if(c=='+')
   	{
	 x=getc(f);
   	 if(x=='+')
   	 {
	  temp[j++]=c;
   	  temp[j++]=x;
   	  printf("%d\t%d\t\tincrementer\t\t%s\n",l,t,temp);
   	  t++;
     }
    }    
    else if(c=='-')
    {
	 x=getc(f);
   	 if(x=='-')
   	 {
	  temp[j++]=c;
   	  temp[j++]=x;
   	  printf("%d\t%d\t\tdecrementer\t\t%s\n",l,t,temp);
   	  t++;
     }
    }
    else if(c=='/')
    {
   	 x=getc(f);
   	 if(x=='*')
   	 {
   	  temp[j++]=c;
   	  temp[j++]=x;
   	  printf("%d\t%d\t\tcomment starts\t\t%s\n",l,t,temp);
	  t++;
   	  x=getc(f);
	  k=0;
   	  while(x!='*')
   	  {
   	  	if(x=='\n')
   	  	 x=' ';
   	  	com[k++]=x;
   	  	x=getc(f);
	  }
	  fseek(f,-1,SEEK_CUR);
	  printf("%d\t%d\t\tcomment\t\t\t%s\n",l,t,com);
	  t++;
   	  for(k=0;k<100;k++)
	   com[k]='\0';
  	 }
	 if(x=='/')
   	 {
   	  temp[j++]=c;
   	  temp[j++]=x;
   	  printf("%d\t%d\t\tcomment starts\t\t%s\n",l,t,temp);
	  t++;
   	  x=getc(f);
	  k=0;
   	  while(x!='\n')
   	  {
   	  	com[k++]=x;
   	  	x=getc(f);
	  }
	  fseek(f,-1,SEEK_CUR);
	  printf("%d\t%d\t\tcomment\t\t\t%s\n",l,t,com);
	  t++;
   	  for(k=0;k<100;k++)
	   com[k]='\0';
	 }
    }
    else if(c=='*')
    {
   	 x=getc(f);
   	 if(x=='/')
   	 {
   	  temp[j++]=c;
   	  temp[j++]=x;
   	  printf("%d\t%d\t\tcomment ends\t\t%s\n",l,t,temp);
   	  t++;
	 }
    }
    else
    {
	 printf("%d\t%d\t\toperator\t\t%c\n",l,t,c);
	 t++;
     }
   }
   else if(isdigit(c))
   {
    	temp[j++]=c;
	c=getc(f);
	while(isdigit(c))
	{
	 temp[j++]=c;
	 c=getc(f);
	}
	fseek(f,-1,SEEK_CUR);
	printf("%d\t%d\t\tdigit\t\t\t%s\n",l,t,temp);
	t++;
   }
   else if(c=='{'||c=='}'||c==';'||c==','||c=='('||c==')'||c=='?'||c=='!')
   {
	printf("%d\t%d\t\tspecial symbol\t\t%c\n",l,t,c);t++;
   }
   else if(c=='#')
   {
   	printf("%d\t%d\t\tpreprocesssor\t\t%c\n",l,t,c);t++;
   }
   else if(c=='\\')
   {
   	y=getc(f);
   	for(i=0;i<3;i++)
	{
	 if(y==echar[i])
	 {
	  temp[j++]=c;
	  temp[j++]=y;
	  printf("%d\t%d\t\tesacpe character\t%s\n",l,t,temp);
	  t++;
	 }
	}
   }
   else if(c==' '){ }	
   else if(c=='\n'){l++;}
   else{ }
   for(i=0;i<20;i++)
	 temp[i]='\0';
  } 
 }
 else
 {
  printf("\nfp file doesnot exist\n");
  return -1;
 }
 fclose(f);
 return 0;
}
