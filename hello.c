#include<stdio.h>
int main()
{
	FILE *fp;
	fp =fopen("file.txt","w+");
	fputc(67,fp);
	fclose(fp);
	return 0;
}
