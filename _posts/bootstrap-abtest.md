

The basic procedure is quite predictable from what you already know. We will

*Calculate F for our sample data (denote it as Fobt)
*Draw B resamples, where each resample is a random permutation of the original data.
	*For each resample, assign the first n1 observations to the first condition, the next n2 observations to the second condition, and so on.
	*For each resample, calculate F from the data.
	*If F > Fobt increment a counter
*After resampling is complete, calculate p by dividing the result in the counter by B.
*p represents the probability of obtaining an F as large as we obtained with our experimental data if the null hypothesis were true.
*Reject or retain the null hypothesis.



iris %>% 
    group_by(Species) %>% 
    summarise_all(mean)

data <- iris
names(data)
data$Species <- as.factor(data$Species)
nreps <- 5000
N <- length(data$Sepal.Width)
n.i <- as.vector(table(data$Species))   # Create vector of sample sizes
k <- length(n.i)

model <- anova(lm(data$Sepal.Width ~ data$Species))
obt.F <- model$"F value"[1]     # Our obtained F  statistic
obt.p <- model$"Pr(>F)"
cat("The obtained value of F from the standard F test is ",obt.F, "\n")
cat("This has an associated probability of ", obt.p,  "\n")
samp.F <- numeric(nreps)
counter <- 0
set.seed(1086)
# time1 <- proc.time()
for (i in 1:nreps) {
    newScore <- sample(data$Sepal.Width)
    newModel <- anova(lm(newScore~data$Species))
    samp.F[i] <- newModel$"F value"[1]
    if (samp.F[i] > obt.F) counter = counter + 1
}
# time2 <- proc.time()
# cat(" The timing statistics are " ,(time2 - time1),"\n")
# The computing time was approx. 10 sec.
pvalue <- counter/nreps
cat("\nThe calculated value of p from randomized samples is ",pvalue, "\n \n")

hist(samp.F, breaks = 50, main = "Histogram of F on Randomized Samples",
     xlab = "F value", probability = TRUE, col = "green", border = 1,
     , xlim = c(0,7), ylim = c(0,1))
legend("topright", paste("obtained.F = ", round(obt.F, digits = 4)), col=1,  cex = 0.8)
legend("right",paste("p-value = ",round(pvalue, digits = 4)))
arrows( 5.5, 0.8,obt.F,0, length = .125)

f <- seq(0, 7,.01)
dens <- df(f,3,41)
par(new = T)
plot(f,dens, col = "red", type = "l", xlim = c(0,7), ylim = c(0,1), xlab = "", ylab = "")

# Fontes:
['Randomization One Way Anova'](http://www.uvm.edu/~dhowell/StatPages/Randomization%20Tests/RandomOneway/RandomOneway.html)