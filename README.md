# Modeliavimas-lab2

Atnaujinta pagal `Laboratorinis darbas 2.pdf` (2026-10-22).

Atidarykite `lab2_main.m` ir paspauskite Run. Reikalingas tik `lagran.m`; papildomų toolbox nereikia.

Studento numeris 20194658: `mod(20194658,5) = 3`. Funkcija `x/(1+x²)`, intervalas [0,2]. Numerį galima pakeisti skripto pradžioje. PDF lentelėje yra ir variantas 5, nors pateikta mod(nr,5) formulė parenka tik 0–4; jo formulė palikta rankiniam pasirinkimui.

Eilės: 2, 3, 5, 7, 9; kiekvienai naudojama n+1 mazgų. Lyginami keturi rezultatai: Lagranžo interpoliacija ir splainas su tolygiais mazgais, Lagranžo interpoliacija ir splainas su Čebyševo mazgais.

Sukuriami tiksliai 6 grafikai: penki aproksimacijų ir vienas visų keturių metodų NMSE. NMSE apibrėžta kaip `sum((y-y_aprox).^2)/sum(y.^2)` 1001 taško tinklelyje. PDF normalizavimo formulės nepateikia. Čebyševo mazgai neapima galų, todėl splainas ties intervalo galais ekstrapoliuojamas.

Paaiškinimas: [SOLUTION.md](SOLUTION.md).
