load(url("http://s3.amazonaws.com/assets.datacamp.com/course/dasi/nc.Rdata"))
names(nc)

# fage: father's age in years.
# mage: mother's age in years.
# mature: maturity status of mother.
# weeks: length of pregnancy in weeks.
# premie: whether the birth was classified as premature (premie) or full-term.
# visits: number of hospital visits during pregnancy.
# marital: whether mother is married or not married at birth.
# gained: weight gained by mother during pregnancy in pounds.
# weight: weight of the baby at birth in pounds.
# lowbirthweight: whether baby was classified as low birthweight (low) or not (not low).
# gender: gender of the baby, female or male.
# habit: status of the mother as a nonsmoker or a smoker.
# whitemom: whether mom is white or not white.

summary(nc)

summary(nc$gained)
# há 27 dados NA nesta variável
boxplot(nc$gained)
plot(nc$gained)

gained_clean = na.omit(nc$gained)
n = length(gained_clean)

# Vamos fazer um bootstrap simples

boot_means <- rep(NA,100)

for (i in 1:100){
  # realizo amostras de tamanho n (neste caso 973) da própria
  # amostra
  boot_samp <- sample(gained_clean, size=n, replace=T)
  # realizo o processo 100 vezes e coloco dentro do vetor
  # boot_means definido fora do "for"
  boot_means[i] <- mean(boot_samp)
}


hist(boot_means)
summary(boot_means)

## Colocar a pergunta na questão 4

#_________________________________________________


load(url("http://assets.datacamp.com/course/dasi/inference.Rdata"))

inference(nc$gained, type = "ci", method="simulation", 
          conflevel=0.95, est ="mean",boot_method="se")

# boot_method = {perc, se} ### Whats de difference?
# to create a interval to the median use est = median instead est = mean

# comparar o intervalo com bootstrap com o intervalo clássico
t.test(nc$gained)


### Procurar sobre a funçaõ Inference e sobre o uso do bootstrap

inference(nc$fage, type="ci", method="simulation", conflevel=0.95, 
          est="mean", boot_method="se")

# relation beetween two variables

plot(nc$weight ~ nc$habi)

# Comparando medidas descritivas
by(nc$weight, nc$habit, median)


by(nc$weight, nc$habit, length)

inference(y=nc$weight, x=nc$habit, est= "mean", type="ht", null=0,
          alternative="twosided", method = "theoretical")

# y -> response variable
# x -> explanatory variable
# est -> {mean, median, proportion}
# type -> {ht, ci} hipotese ou intervalo de confiança
# null = 0 -> valor da hipotese nula
# alternative -> {less, greater, twosided}
# method -> {theoretical, simulation}


# Mudando a ordem

inference(y=nc$weight, x=nc$habit, est= "mean", type="ht", null=0,
          alternative="twosided", method = "theoretical",
          order = c("smoker","nonsmoker"))

# Rodando uma intervalo de confiança para nonsmokers

inference(y=nc$weight, x=nc$habit, est= "mean", type="ci", null=0,
          alternative="twosided", method = "theoretical",
          order = c("smoker","nonsmoker"))


# The general social survey
load(url("http://s3.amazonaws.com/assets.datacamp.com/course/dasi/gss.Rdata"))
head(gss)

summary(gss$wordsum)
summary(gss$class)
hist(gss$wordsum)
boxplot(gss$wordsum)

by(gss$wordsum, gss$class, mean)
plot(gss$wordsum ~ gss$class)

inference(y= gss$wordsum, x= gss$class, est = "mean", method = "theoretical",
          type="ht", alternative="greater")
# Note that the alternative hypothesis is set to greater because F-tests are 
# always onesided.

# mudando o alfa
inference(y= gss$wordsum, x= gss$class, est = "mean", method = "theoretical",
          conflevel=0.95, type="ht", alternative="greater")

inference(y = gss$wordsum, x = gss$class, 
          est = "mean", method = "theoretical", 
          type = "ht", alternative = "greater")

