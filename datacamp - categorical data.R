# Load in the atheism data set with the help of the provided function.
load(url("http://assets.datacamp.com/course/dasi/atheism.RData"))


head(atheism)
table(atheism$response)

us12 <- subset(atheism, atheism$nationality == "United States" & atheism$year == "2012")
head(us12)

proportion1 <- nrow(subset(us12,response == 'atheist'))/nrow(us12)
# Sugestão
proportion2 <- nrow(us12[us12$response == 'atheist',])/nrow(us12)
# 
proportion3 <- with(data=atheism, split(x=atheism, f=year))

# Construir o intervalo de confiança
install.packages("inference")
inference(us12$response, est='proportion', type='ci', method="theoretical",
          success ="atheist")

# I cant used that, because my R isnt run.
# The margin of error for the estimate of the proportion of atheists in the US in 2012 is 0.0135.

# Calculando a margem de erro
n <- 100
p <- seq(0,1,0.01)

erro_padrao <- sqrt(p*(1-p)/n)
int_conf <- 1.96*erro_padrao

plot(int_conf ~ p)

# O erro padrão é máximo quando a estatística p = 0.5. Faz sentido, pois neste caso temos
# informação mínima
