# Sprendimo paaiškinimas

1. Pagal studento numerį parenkama funkcija ir intervalas.
2. Kiekvienai eilei n sudaromi n+1 tolygiai išdėstytų taškų ir Čebyševo mazgų. Čebyševo formulė: `xc = (a+b)/2 + (b-a)/2*cos((2*k+1)*pi/(2*(n+1)))`, k=0,...,n.
3. Abiem mazgų rinkiniams kviečiama ta pati paprasta `lagran()` funkcija ir MATLAB `spline()`.
4. Rezultatai palyginami su tikrąja funkcija 1001 taško tinklelyje. NMSE yra kvadratinių paklaidų sumos ir tikrosios funkcijos kvadratų sumos santykis; mažesnė reikšmė reiškia mažesnę paklaidą.
5. Penkiuose grafikuose matyti funkcija, keturios aproksimacijos ir abu mazgų rinkiniai. Šeštame parodyta NMSE priklausomybė nuo eilės.

Pagal atnaujintą užduotį Padé ir atskira Niutono aproksimacija nereikalingos.
