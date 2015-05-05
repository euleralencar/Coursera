# Bootstrap 95% CI para o R-Quadrado
library(boot)

# Função para obter o R-Quadraro a partir de uma base de dados
rsq <- function(formula, data, indices)
{
  d <- data[indices,] # permite boot para selecionar amostra
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
}

# bootstrapping com 1000 repetições
results <- boot(data=mtcars, statistic=rsq, R=1000, formula=mpg~wt+disp)

# Apresenta os Resultados
results
plot(results)

# intervalo de confiança de 95%
boot.ci(results)
#names(results)


#________________
# outra metodologia
#_________________

0 - ppois(0,lambda=2)
0.3 - ppois(1,lambda=2)
0.6 - ppois(2,lambda=2)
0.7 - ppois(3,lambda=2)
0.9 - ppois(4,lambda=2)
1 - (ppois(100,lambda=2) - ppois(4,lambda=2))

### Exemplo BootStrap ####
library(bootstrap)
data(law)

#Estimativa Bootstrap do viés do coef. Correlação R
theta.hat <- cor(law$LSAT, law$GPA)

#Estimativa bootstrap do viés
B <- 2000 #Número de réplicas
n <- nrow(law)
theta.b <- numeric(B)
  for (b in 1:B) {
      i <- sample(1:n, size = n, replace=TRUE) # i é o vetor dos índices
      LSAT <- law$LSAT[i]
      GPA <- law$GPA[i]
      theta.b[b] <- cor(LSAT,GPA)
  }
bias <- mean(theta.b) - theta.hat
bias

#________________________
#
#________________________












