#do czego potencjalnie w praktyce mogą być wykorzystane odkryte reguły??

# 1. jeżeli np analiza koszykowa pokaze, ze zakup jednego produktu 
# pociaga za soba zakup produktu drugiego to sprzedawca moze obnizyc 
# cene jednego produktu aby przciagnac klienta do sklepu a podwyzszyc
# cene drugiego

# 2. analiza koszykowa moze rowniez pomoc w optymalnym rozmieszczeniu produktow
# w sklepie (rzeczy kupowane razem powinny znajdowac sie np na tym samym regale)


# Miary oceny reguł:

# 1. support (wsparcie), wyznacza się dla zbioru.
# Określa do jakiej części transakcji stosuje się dany zbiór. To iloraz 
# liczby transakcji zawierających produkty ze zbioru do liczby wszystkich transakcji


# 2. Confidence (wiarygodność/ufność), czyli procent transakcji zgodnych z regułą 
# (zawierających produkty z obu stron) do transakcji zgodnych z lewą stroną reguły 
# (zawierających produkty z prawej strony)

# Lift (podniesienie), czyli ilukrotnie częściej w transakcjach występuje lewa i prawa 
# strona w stosunku do częstości spodziewanej, gdyby obie strony występowały niezależnie


library("arules")
data("Groceries")
Groceries
head(Groceries@itemInfo)
dim(Groceries@data)

# dane przechowywane sa w postaci macierzy zer i jedynek
Groceries@data[1:5,1:30]

# krotka wizualizacja
image(head(Groceries,300))


# algorytm apriori

# 1. Znajdź wszystkie jednoelementowe zbiory XX, takie które supp(X) \geq min_ssupp(X)≥min

# 2. Na podstawie zbiorów o wielkości kk wygeneruj zbiory 
# o wielkości k+1k+1 przez dodanie po jednym produkcie. Pozostaw tylko te, zbiory których wsparcie jest większe niż min_smin

# Powtarzaj krok 2.

rules <- apriori(Groceries, parameter = list(support = .001))
rules

rules_2 <- apriori(Groceries, parameter = list(support = 0.01, confidence = 0.5))
rules_2

# asocjacje z konkretnym produktem
fruit_rules <- apriori(data=Groceries, parameter=list (supp=0.001,conf = 0.08), appearance = list (rhs="tropical fruit"))
fruit_rules

# wyswietlanie najwazniejszych asocjacji
inspect(head(sort(fruit_rules, by = "lift"), 4))
inspect(head(sort(rules, by = "lift"), 4))
inspect(head(sort(rules, by = "confidence"), 4))


# wizualizacje
library(arulesViz)
plot(rules)

itemFrequencyPlot(Groceries, topN =20)

plot(head(sort(rules, by="lift"), 50),  method="graph", control=list(cex=.7))

