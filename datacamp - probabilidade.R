# DataCamp - Probabilidade

load(url("http://s3.amazonaws.com/assets.datacamp.com/course/dasi/kobe.RData"))
length(kobe$basket)

kobe_streak = calc_streak(kobe$basket)
barplot(table(kobe_streak))
IQR(kobe_streak)

basket_num = rep(NA,length(kobe$basket))
# IF mais legal
basket_num[kobe$basket=="H"]=1
basket_num[kobe$basket=="M"]=0

# Hot hand -> P(shot2 = H | shot1 = H) >= 0,45, if P(shoot1 = H)
# Vamos simular um jogador sem Hot Hand.
# Exemplo com moedas de simulação
outcomes <- c("heads", "tails")
table(sample(outcomes, size = 5, replace=T))

### Simulação do Jogador com not Hot Hand
outcomes <- c("H","M")
prob_basket <- c(0.45,0.55)
sim_basket <- sample(outcomes, size=length(kobe$basket), prob=prob_basket, replace = T)
table(sim_basket)  ## Verificar se está próximo da estatística da simulação

#Vamos computar a mesma estatística que fizemos para Kobe
sim_streak = calc_streak(sim_basket)

summary(kobe_streak)
summary(sim_streak)

# barplots
kobe_table <- table(kobe_streak)
sim_table <- table(sim_streak)

barplot(kobe_table)
barplot(sim_table)

#install.packages("randomLCA")#####
#calcCond(kobe$basket, prevshots=1)
#?calcCond
#calc.cond.prob(kobe$basket)#####

Oi <- margin.table(kobe_table,1)
Ei <- margin.table(sim_table,1)

prob_Oi <- (prop.table(kobe_table))
prob_Ei <- (prop.table(sim_table))

Oi_l1 <- c(prob_Oi,0,0)
Ei_l2 <- c(prob_Ei)


X2 <- sum((Oi_l1 - Ei_l2)^2/Ei_l2)
nu <- length(Oi_l1)-1                              # graus de liberdade
pchisq(X2, df=nu, lower.tail=FALSE)  
# Ho: Kobe é indep. de Sim
chisq.test(Oi)

# Novo teste utilizando uma tabela

a2 <- kobe$basket[2:133]
a1 <- kobe$basket[1:132]

tabela <- table(a1,a2)
chisq.test(tabela)

#prop.table(tabela)
#prop.table(tabela,2)

a1 <- kobe$basket[2:133]
a2 <- kobe$basket[1:132]

tabela <- table(a1,a2)

prop.table(tabela)

chisq.test(tabela)

# Não rejeitamos, já que o p-valor foi acima de 0.05.

### Novos Procedimentos
