# Sprendimas: interpolacija

[lab2_main.m](lab2_main.m) vykdo visus šešis variantus ir penkias eiles. Naudojamos paprastos pagalbinės funkcijos iš dėstytojo pateikto pavyzdžio:

- `lagran.m`: Lagranžo bazinių daugianarių sandaugos ir jų suma.
- `niuton.m`: padalytųjų skirtumų lentelė ir Niutono daugianaris.
- `cheby.m`: Čebyševo mazgai ir koeficientai.
- `padeap.m`: pateikto `pade.m` funkcija, pritaikyta stabiliems koeficientams ir singuliarioms sistemoms.
- MATLAB `spline()`: kubiniai interpoliuojantys splainai.

Pateiktų `lagran.m` ir `niuton.m` pirmosios funkcijos buvo pavadintos `lagranp` ir `newtonp`. Pavadinimai suderinti su failais.

Padé skaičiavimas perkeltas iš pagrindinio skripto į atskirą funkciją. Kvietimas: `[num,den,t,M,N]=padeap(f,x0,M,N,a,b,c)`. Išėjimo daugianarių koeficientai, kaip pateiktame pavyzdyje, išdėstyti mažėjančia laipsnių tvarka. `taylor_coefficients()` ir `difapx()` taip pat yra atskiruose failuose.

## Padé ir Teiloro eilutė

Centras **x0=(a+b)/2**. Teiloro koeficientai apskaičiuojami iš žinomų logaritmo, eksponentės ir daugianarių eilučių. Jei f=p/q, koeficientai randami iš **q(s)c(s)=p(s)**, kur s=x-x0. Taip nereikia nestabilių aukštos eilės skaitinių išvestinių ar papildomo toolbox.

Padé ieškoma kaip **P_M(s)/Q_N(s)**, pradžioje M=floor(n/2), N=n-M, Q(0)=1. Koeficientai gaunami iš Teiloro koeficientų tiesinių lygčių. Kai sistema singuliari, vardiklio laipsnis mažinamas, o skaitiklio didinamas išlaikant M+N=n. Tai leidžia tvarkingai apdoroti funkcijas, kurios jau yra mažesnės eilės racionaliosios funkcijos; kai N=0, rezultatas yra Teiloro daugianaris.

Pradiniame pateiktame `pade.m` aukštos eilės išvestinės skaičiuotos baigtiniais skirtumais ir dalinta iš paskutinio vardiklio koeficiento. Šiame sprendime koeficientai skaičiuojami tiesiogiai ir vardiklio pastovusis narys normalizuotas į 1.

## Klaidos ir MATLAB rezultatai

MSE yra **mean((f-yApprox).^2)** 1001 vienodai išdėstytame tikrinimo taške. Maksimali klaida yra **max(abs(f-yApprox))** tame pačiame tinklelyje. Padé poliui esant intervalo viduje, tikroji maksimali klaida pažymima `Inf`; MSE lieka diskretaus tinklelio matas. Grafike ties poliumi paliekamas tarpas.

MSE, kai n=9, gauti MATLAB R2026a:

| Variantas | Lagranžas | Čebyševas | Padé | Splainas |
|---|---|---|---|---|
| 1 | 1.6988e-8 | 1.7435e-9 | 1.6957e-14 | 1.1282e-6 |
| 2 | 1.1394e-2 | 2.5257e-4 | 2.6805e-5 | 3.9670e-7 |
| 3 | 6.6226e-1 | 1.2207e-2 | 0 | 3.0803e-3 |
| 4 | 3.3509e-9 | 4.1316e-10 | 1.0994e-33 | 1.0155e-7 |
| 5 | 2.1531e-7 | 9.8044e-9 | 2.4430e-32 | 1.0936e-7 |
| 6 | 3.4090e-3 | 6.0617e-4 | 6.1116e-34 | 2.4247e-5 |

Niutono ir Lagranžo metodai naudoja tuos pačius mazgus ir aprašo tą patį interpoliuojantį daugianarį. Nedidelius skirtumus sukelia apvalinimas.

Plačiuose intervaluose vienodų mazgų polinominė interpolacija gali svyruoti: 3 variantui didinant n paklaida padidėja. Čebyševo mazgai sumažina svyravimus. Padé tiksliai atkuria racionaliąsias funkcijas, kai pakanka skaitiklio ir vardiklio laipsnių. Žema eilė nebūtinai duoda gerą rezultatą: 1 varianto Padé [1/2] turi polių ties **x≈1.98758**.

Paleisti visi 30 funkcijos ir eilės derinių. Patikrintas Lagranžo ir Niutono sutapimas bei mazgų atkūrimas. MATLAB statinis analizatorius pastabų nerado.
