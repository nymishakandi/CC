#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include<math.h>
int l,w,i,f,ch;
bool isInt(char *,int *);
bool isFloat(char *,float *);
int main()
{
    FILE *fp;
    l=w=i=f=ch=0;
    char c;
    int sumi=0;
    float sumf=0.0;
    fp=fopen("data.txt","r");char buf[100];int p=0;
    if(fp==NULL)
    exit(1);
    else
    {
        while((c=fgetc(fp))!=EOF)
        {
            if(c!=' '&&c!='\n'&&c!='\r')
            {
                buf[p++]=c;
		ch++;
            }
            else // if(c==' '||c=='\n'||c=='\r')
            {
                buf[p]='\0';
                //printf("%s\n",buf);
                if(c=='\n')//||c=='\r')
                l++;
                int getint;float getfloat;
                if(isInt(buf,&getint))
                {
			printf("integer:%s\n",buf);
              //      i++;
                    sumi+=getint;
                }
                else if(isFloat(buf,&getfloat))
                {
			printf("float:%s\n",buf);
            //        f++;
                    sumf+=getfloat;
                }
  		else
		{
		    printf("word:%s\n",buf);	
                    w++;
		}
                buf[p]='\0';
                p=0;
            }
           // printf("%d %d %d %d %s",i,l,f,w,buf);

        }
    }
printf("sum if ints %d\n",sumi);
printf("sum of floats %f\n",sumf);
printf("no of words %d\n",w);
printf("no of lines %d\n",l);
printf("no of integers %d\n",i);
printf("no of floats %d\n",f);
printf("no of characters %d\n",ch);
}
bool isInt(char *s,int *int_val)
{
   //     printf("hi %d\n",*getint);
	*int_val=0;
    int sign=1;
    int p;
    if(s[0]=='-')
        sign=-1;
    if(s[0]=='+'||s[0]=='-'||(s[0]>=48&&s[0]<=57))
    {
        if(s[0]>=48&&s[0]<=57)
        *int_val=(int)(s[0]-48);
    }
    else
        return false;
    for(p=1;s[p]!='\0';p++)
    {
        if(s[p]>=48&&s[p]<=57)
        {
            *int_val=(*int_val)*10+(int)(s[p]-48);
        }
        else
            return false;

    }
    *int_val=(*int_val)*sign;
	i++;
    return true;
}
bool isFloat(char *s,float *float_val)
{
	//printf("hi 3 : %s",s);
    float sign=1.0;
    *float_val=0.0;
    int i;int count=0;
    if(s[0]=='-')
        sign=-1.0;
    if(s[0]=='+'||s[0]=='-'||(s[0]>=48&&s[0]<=57))
    {
        if(s[0]>=48&&s[0]<=57)
        *float_val=(*float_val)*10.0+(float)(s[0]-48);
    }
    else
        return false;
	int flag=0;int power1=-1;
	//printf("hi 4:%f",*getfloat);
    for(i=1;s[i]!='\0';i++)
    {
        if(s[i]=='.'&&count==0)
        {
            count++;flag=1;
		continue;
        }
        else if(s[i]=='.'&&count>0)
            return false;
        if((s[i]>=48&&s[i]<=57)&&flag==0)
        {
            *float_val=(*float_val)*10+(s[i]-48);
        }
        else if((s[i]>=48&&s[i]<=57)&&flag==1)
        {
                *float_val=(*float_val)+(s[i]-48)*(pow(10,power1));
                power1--;
        }
        else
            return false;

    }
    *float_val=(*float_val)*sign;
	f++;
    return true;
}


