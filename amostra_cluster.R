um <- rep(1,11)
dois <- rep(2,11)
area <- c(um,dois)
age1 <- seq(15,25)
age2 <- seq(25,35)
age <- c(age1,age2)
ex <- cbind(area,age)

summary(ex)

data = data.frame(y=age, group=factor(area))
fit <- lm(y ~group, data)
anova(fit)

df = anova(fit)[, "Df"]
names(df) = c("trt","err")
alpha <- c(0.05, 0.01)
qf(alpha, df1=df["trt"],df2=df["err"],lower.tail=FALSE)

anova(fit)["Residuals", "Sum Sq"]

anova(fit)["Residuals", "Sum Sq"]/qchisq(c(0.025,0.975),18,lower.tail=FALSE)
