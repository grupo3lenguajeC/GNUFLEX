%{
#include <stdio.h>
#include <conio.h>
int num_lineas = 0, num_caracteres = 0;
%}
%option noyywrap
%option yylineno
palabrasClave	[if+else+for+function-while]
identificador	i
latinoM		[A-Z]
latinom		[a-z]
entero [0-9]
ignora " "|\t|\n
operarit *|+|-|/
%%
{palabrasClave}+	    {printf("PALABRARESERVADA\n");}
{identificador}
{identificador}{latinoM}({entero}+{latinom}*)|{identificador}{latinoM}({latinom}+{entero}*)	{printf("IDENTIFICADOR\n");}	
{latinoM}+|{latinoM}+{entero}+|{identificador}{latinoM}+({latinom}*)({entero}*)|{identificador}({entero}*)({latinoM}+{latinom}*)|({latinoM}+{latinom}*)|{entero}+({latinoM}+{entero}*)|{identificador}{entero}+ {printf("ERROR LEXICO\n");}	
{entero}+                   {printf("ENTERO\n");}
{entero}+"."{entero}+	      {printf("REAL\n");}
\n                          ++num_lineas;

%%
int main(int argc,char *argv[])
{
    char NomArch[30];
    printf("Ingrese nombre de archivo: ");
    gets(NomArch);
    if ((yyin = fopen(NomArch, "rt")) == NULL)
    {
        printf("\nNo se puede abrir el archivo: %s\n", NomArch);
    }
    else
    {
        yylex();
    }
    fclose(yyin);
    getch();
    return 0;
}
