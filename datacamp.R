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

