#include<stdio.h>
	int i=0;
	char a[10];
	void e();
	void e1();
	void t();
	void t1();
	void f();
	int main()
	{
		while(1)
		{
			printf("\nEnter  a string :\n");
			scanf("%s",&a);
			if(strcmp(a,"bye"))
			{
				e();
				if(a[i]=='$')
					printf("Successful parse\n");
				else
					printf("Unsucessful parse\n");
			}
			else
			break;
		}
		return 0;
	}
	void e(void)
	{
		t();
		e1();
	}
	void e1(void)
	{
		if(a[i]=='+')
		{
			i++;
			t();
			e1();
		}
	}

	void t(void)
	{
		f();
		t1();
	}
	void t1(void)
	{
		if(a[i]=='*')
		{
			i++;
			f();
			t1();
		}
	}
	void f(void)
	{
		if(a[i]=='(')
		{
			i++;
			e();
			if(a[i]==')')
			i++;
		}
		else if(a[i]=='i')
			i++;
	}
