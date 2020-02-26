				   Copyright @ 2019 Grecu Andrei-George, All rights reserved

							 Steganography

					TEXT: https://ocw.cs.pub.ro/courses/iocla/teme/tema-2


	Task1:
			Reprezinta implementarea task-ului 1 prin functia bruteforce_singlebyte_xor.
			
			Aceasta ia pentru o cheie (in edx) ce se incrementeaza si pentru fiecare se verifica matricea.

			La fiecare pas se verifica cate un element si se incearca matching-ul acesteia cu prima litera 
		din cuvantul cautat 'r'.

			Daca aceasta a fost gasita se verifica urmatoarul pixel din imagine pentru a vedea daca este continuarea 
		cuvantului. Se repeta pana se ajunge la finalul cuvantului. (case-uri: n1, n2, n3, ...)

			Daca s-a gasit, se iese din loop, se afla linia si se retine impreuna cu cheia pentru a fi folosite 
		ulterior la printare.

			Pentru a duce la capat task-ul, se face prelucrarea si printarea stringului, cheii si liniei.


	Task2:
			Reprezinta implementarea task-ului 2 care se foloseste de o functie implementata in task1
		(bruteforce_singlebyte_xor) pentru a obtine o cheie si o linie.
		
			In xormap se face decriptarea imaginii aplicand xor pe valorile ei si modificandu-le.

			Pentru a introduce mesajul pe linia urmatoare mesajului primit, ne vom folosi de cheia
		si linia aflate anterior.
			
			Mesajul vrem il punem pe stiva, apoi copiat pe pozitia corespunzatoare.
	
			Calculam noua cheie pentru criptare si o folosim sa criptam imaginea (xormapp).


	Task3:
			Reprezinta implementarea pentru task-ul 3 prin functia morse_encrypt.
		
			Se ia fiecare caracter din stringul primit ca parametru si este criptat prin codul morse
		si introdus in imagine. (copymorse->morse)

			morse este functia ce transforma fiecare caracter primit ca parametru, in codul morse si
		modifcat in imagine.

			In copy_morse, daca se termina propozitia, se iese din task (leavetask)


	Task4:
			Reprezinta implementarea pentru task-ul 4 prin functia lsb_encode care primeste un string
		si index ca parametri, pentru a encode mesajul la indexul dat.
		
			Se ia fiecare caracter din mesaj, se fac 8 rotatii la stanga, si la fiecare rotatie se ia
		ultimul bit si acesta se pune ca fiind ultimul bit din valoarea pixelui din imagine.

			Daca s-au facut 8 rotatii, se verifica daca s-a ajuns la finalul mesajului.

			Daca s-a ajuns la final, la caracterul null, se iese din functie, altfel se trece la urmatorul
		caracter si se incepe procesul din nou.

			Daca nu s-au facut 8 rotatii, se continua rotatiile si modificarile aduse la matrice.


	Task5:
			Reprezinta implementarea pentru task-ul 5 prin functia lsb_decode care decodeaza un mesaj dintr-o
		imagine data, si se afiseaza caracter cu caracter, pana se intalneste terminatorul de sir.

			Se creeaza caracter prin shiftari, si-uri logice si adunari multiple.


	Task6:
			Reprezinta implementarea pentru task-ul 6 prin functia blur, care modifica pixelii din imagine,
		aplicand acest filtru de imagine.

			Se pun pe stiva noile valori calculate ale pixelilor (conform restrictiilor) si se vor inlocui
		ulterior cele din imagine (deoarece trebuie calculate noile valori cu valorile din imaginea veche,
		nu cu valorile ce se modifica).

			

			

