data <- read.table.url("http://www.stat.wisc.edu/~rich/JWMULT06dat/T8-6.DAT",method="auto")

download.file("http://www.stat.wisc.edu/~rich/JWMULT06dat/T8-6.DAT", "dados.dat")
dados <- read.table("dados.dat")
head(dados)

#Nome das variáveis
provas <-  c("100 m (s)", "200 m (s)", "400 m (s)", "800 m (min)", "1500 m (min)", "5000 m (min)", "10000 m (min)",
             "Maratona (min)")

# Coletar apenas os nomes dos Id´s do Banco de Dados
paises <- dados[,1]

# Retirar o Id do banco de dados e guardar em países
dados <- dados[,-1]

# Associar os nomes das variáveis com os nomes que estabelecemos lá em cima
names(dados) <- provas
head(dados)

summary(dados)

# Desvio padrão dos variáveis
apply(dados, 2, sd)

# Matriz de correlações
matcor <- cor(dados)
print(matcor, digits=3)

install.packages("lattice")
library(lattice)

#gráfico das correlações cruzadas 2 a 2
splom(dados, pch=20, col="black", xlab = "")

acpcor <- prcomp(dados, scale=TRUE)
summary(acpcor)

# Desvio padrão das componente é igual a 8 (somas dos autovalores), como esperado.
sum(acpcor$sdev^2)

# Variância do primeiro componente
acpcor$sdev[1]^2

# Gráfico com a variância de cada componente principal
plot(1:ncol(dados), acpcor$sdev^2, type="b", xlab="Componente", ylab="Variância",
     pch=20, cex.axis = 1.3, cex.lab= 1.3)

names(acpcor)

#Os dois primeiros componentes estão dados abaixo:
acpcor$rotation[, 1:2]

# As correlações entre os dois primeiros componentes principais e as variáveis estimadas
print(acpcor$sdev[1:2]*t(acpcor$rotation[,1:2]),digits=3)


acpcor <- prcomp(dados, scale=TRUE, retx = TRUE)
names(acpcor)
cor(acpcor$x)

#Atribuimos os escores da primeira componente (que é um indicador de desempenho)
#para cada um dos países
escores1 <- acpcor$x[,1]
names(escores1) <- paises
#escores1
ordem <- order(escores1, decreasing=T)
barplot(escores1[ordem], ylab = "Escores do CP1", las=2); box()

# Plot de um componente CP1 pelo componente CP2, com seus respectivos
# vetores (e1j, e2j. 
biplot(acpcor, xlab="CP1", ylab="CP2", cex.lab=1.5, cex.axis=1.5)

dados$id[40]

##################################################################
