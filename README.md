# Modeliavimas-lab2

## Užduotis: interpolacija ir funkcijos aproksimacija

Visi funkcijų variantai:

| Nr. | Funkcija | Intervalas |
|---|---|---|
| 1 | (1+x)/ln(1+x) | [1, 5] |
| 2 | 1/(1+exp(x)) | [-10, 10] |
| 3 | x/(1+x²) | [-10, 10] |
| 4 | x/(1+x²) | [0, 2] |
| 5 | 1/(1+x³) | [0, 2] |
| 6 | 1/(1+x⁴) | [-2, 2] |

Aproksimuokite funkcijas Lagranžo, Niutono, Čebyševo daugianariais, Padé racionaliąja funkcija ir splainais. Aproksimacijos eilės: **2, 3, 5, 7, 9**.

1. Nubraižykite funkciją, visų metodų rezultatus, naudotus taškus ir Čebyševo mazgus.
2. Padé metodui atvaizduokite naudotą Teiloro eilutę.
3. Apskaičiuokite ir nubraižykite MSE bei maksimalios absoliučios klaidos priklausomybę nuo eilės.

Šaltinis: `interp.pdf` ir dėstytojo pateiktos `interp.zip` funkcijos.

## Atskiros funkcijos

Pagrindinis skriptas iš tikrųjų kviečia `lagran()`, `niuton()`, `cheby()` ir `padeap()` iš atskirų `.m` failų. `padeap.m` yra pateikto `pade.m` adaptacija: išlaikyta Teiloro koeficientų suderinimo sistema, pridėtas singuliarios sistemos apdorojimas ir saugus vardiklio normalizavimas.

`taylor_coefficients.m` pateikia tikslius šešių užduoties funkcijų Teiloro koeficientus. Juos skriptas perduoda `padeap()` papildomu septintu argumentu. Be šio argumento `padeap()` naudoja pateiktą `difapx()` skaitinių išvestinių kelią; jis taip pat paliktas atskirame faile.

## Paleidimas

Atidarykite [lab2_main.m](lab2_main.m) ir paspauskite **Run**. Visus `.m` failus laikykite tame pačiame aplanke. Papildomų toolbox nereikia: Teiloro koeficientai apskaičiuojami žinomų laipsninių eilučių koeficientų palyginimu.

Pagal nutylėjimą vykdomi visi šeši variantai (`variants = 1:6`). Vienam variantui, pavyzdžiui, nustatykite `variants = 1`.

Kiekviena n eilė naudoja n+1 interpolacijos taškų. Padé skaitiklio ir vardiklio laipsnių suma yra n. Skriptas sukuria 36 grafinių langų, todėl pasirinkti vieną variantą patogu peržiūrai.

Klaidos vertinamos 1001 taško tinklelyje. Jei Padé turi polių intervalo viduje, tikroji maksimali klaida yra `Inf`; apie polių pranešama ir grafiko kreivė ties juo nutraukiama. Kitais atvejais maksimali klaida yra tinklelio įvertis.

Paaiškinimas: [SOLUTION.md](SOLUTION.md).
