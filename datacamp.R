load(url("http://s3.amazonaws.com/assets.datacamp.com/course/dasi/kobe.RData"))
head(kobe) # or use tail
names(kobe)
kobe$basket[1:9]

# Numero de sucessos até o primeiro fracasso
kobe_streak = calc_streak(kobe$basket)
head(kobe_streak)
kobe_streak
length(kobe_streak)
length(kobe$basket)
barplot(table(kobe_streak))

vetor = rep(NA,length(kobe$basket))
# IF mais legal
vetor[kobe$basket=="H"]=1
vetor[kobe$basket=="M"]=0

# Quantidade de acertos durante a partida
tent <- sum(vetor)/length(vetor)

#Question3 - Probability
sd(kobe_streak)/mean(kobe_streak)
IQR <- quantile(kobe_streak, 0.75) - quantile(kobe_streak, 0.25)
length(which(kobe_streak==3))
length(which(kobe_streak==4))

p_shoot1 <- length(which(kobe_streak>0))/length(kobe_streak)
p_shoot2 <- length(which(kobe_streak>1))/length(kobe_streak)
p_shoot3 <- length(which(kobe_streak>2))/length(kobe_streak)
p_shoot1_and_p_shoot2 <- length(which(kobe_streak>1))/length(kobe_streak) 
p_shoot2_given_shoot1 <- p_shoot1_and_p_shoot2/p_shoot1
p_shoot2_and_p_shoot3 <- length(which(kobe_streak>2))/length(kobe_streak) 
p_shoot3_given_shoot2 <- p_shoot2_and_p_shoot3/p_shoot2
p_shoot3_and_p_shoot4 <- length(which(kobe_streak>3))/length(kobe_streak) 
p_shoot4_given_shoot3 <- p_shoot3_and_p_shoot4/p_shoot3

Oi <- c(p1 = p_shoot1, p2= p_shoot2_given_shoot1, p3= p_shoot3_given_shoot2, p4= p_shoot4_given_shoot3)
Ei <- rep(tent,4)
X2 <- sum((Oi-Ei)^2/Ei)
nu <- length(Oi)-1
teste.aderencia <- pchisq(X2, df=nu, lower.tail=FALSE)
teste.aderencia
chisq.test(Oi)
# O p-valor foi de 0,9702 logo rejeita-se Ho, isto é, concluí-se que o
# número a probabilidade não é a mesma

Oi <- c(seg=32, ter=40, qua=20, qui=25, sex=33) # observados
Ei <- sum(Oi)/length(Oi)                        # esperados sob H_0
X2 <- sum((Oi-Ei)^2/Ei)                         # estatística do teste
nu <- length(Oi)-1                              # graus de liberdade
pchisq(X2, df=nu, lower.tail=FALSE)  
chisq.test(Oi)



#Pequeno exemplo
x <- c(A = 20, B = 15, C = 25)
chisq.test(x)$p.value
