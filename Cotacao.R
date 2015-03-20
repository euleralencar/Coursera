library(XLConnect)
cotacao <- readWorksheetFromFile("C:\\Users\\t318769.TRIBUNAL\\Desktop\\IBVindice.xlsx", sheet=1, header=T)
head(cotacao)
attach(cotacao)
plot(Cotacao, type="l")
#abline(Cotação ~ Id)

taxa_mes <- rep(NA, length(cotacao[,6])-1)
length(taxa_mes)

j <- length(cotacao[,6])-1
for (i in 1:j){
  taxa_mes[i] <- (Cotacao[i+1]/Cotacao[i]-1)
}

taxa_mes <- taxa_mes[-73]

taxa_anual <- rep(NA,72/12)

ano1 <- c()

for (i in 1:6){
  for (j in 1:12){
    contador = 12*(i-1) + j 
      ano1[j] <- 1 + taxa_mes[contador]
  }
  taxa_anual[i] <- prod(ano1)
}

ano2 <- c()
s <- seq(1,72, by=12)
c <- 1
for (i in s){
  ano2[c] <- prod((taxa_mes+1)[i:(i+11)])
  c = c+1
}

taxa_anual
ano2


taxa_anual

a <- c(1,2,3)
prod(a)

taxa_mes

variacao <- rep(NA,12)
for (i in 1:12){
  variacao[i] <- (Cotacao[i+11]/Cotacao[i]-1)
}

variacao
mean(variacao)

cotacao



