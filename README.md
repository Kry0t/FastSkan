# FastSkan

Fast Skan es una herramienta muy sencilla hecha en bash con la finalidad de automatizar el proceso de reconocimiento de una máquina.

Esta herramienta fue principalmente diseñada para analizar máquinas boot2root de plataformas como HackTheBox o TryHackMe

### ¿Como utilizar Fast Skan?

> ℹ️ Para un uso optimo recomiendo agregar el ejecutable al PATH

![alt text](https://github.com/Kry0t/FastSkan/blob/main/images/1.png)

* -s IP 
* -w Diccionario para fuzzear directorios
* -n Nombre Servidor



Tras ejecutar el script veremos que esta corrobara que se tengan instaladas las aplicaciones necesarias.

Si todo esta correcto iniciara el escaneo de puertos con nmap, indicandonos en pantalla un breve resumen de los puertos abiertos mientras continua haciendo un analisis mas completo de los mismos.

Luego continuara haciendo un fuzzeo de directorios y realizando un reconocimiento de tecnologias utilizadas en el sitio web.

![alt text](https://github.com/Kry0t/FastSkan/blob/main/images/2.png)



### TO DO
* Hacer un reconocimiento de cada puerto segun los resultados de nmap, no solo del puerto 80.
