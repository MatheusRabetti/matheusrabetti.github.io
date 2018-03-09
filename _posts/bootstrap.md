---
layout: post
title: When distributions fail
categories:
  - Statistics
description: Nonparametric, permutations and bootstrap
tags: [ab testing]
---

Sometimes we can't use them

* Sample size too small for asymptotic distributions (can't use CLT)
* Shape is qualitatively wrong (skewness)
* Some other assumptions are unrealistic (heteroscedasticity)

In consulting we usually encounter non-parametric methods in the context of two sample tests. If the data don’t look normal and/or the sample size is too small to rely on asymptotic assumptions, we may be skeptical of a very small p-value coming from a t test.

What do we do?

* Mann-Whitney U test (aka Wilcoxon rank-sum test) if the samples are not paired, or Wilcoxon signed-rank test (or sign test, more general) for paired samples.
* If interested in proportions rather than location shift (median), McNemar’s test.
* Kruskal-Wallis if there are more than two groups (one way ANOVA).
* Kolmogorov-Smirnov to test if one sample comes from a given distribution or if two samples have equal distributions.

And many more... (anything based on ranks or ecdf)

Resampling methods are used in:

1. Estimating precision / accuracy of sample statistics through using subset of data (jackknifing) or drawing randomly with replacement from a set of data points (bootstrapping)
2. Exchanging labels on data points when performing significance tests (permutation tests)
3. Validating models by using random subsets (bootstrapping, cross validation)

The regular bootstrap and the jackknife, estimate the variability of a statistic from the variability of that statistic between subsamples, rather than from parametric assumptions. For the more general jackknife, the delete-m observations jackknife, the bootstrap can be seen as a random approximation of it. Both yield similar numerical results, which is why each can be seen as approximation to the other.

# Bootstrapping

Bootstrapping is a statistical method for estimating the sampling distribution of an estimator by sampling with replacement from the original sample. The method assigns measures of accuracy (defined in terms of bias, variance, confidence intervals, prediction error or some other such measure) to sample estimates.

The basic idea of bootstrapping is that inference about a population from sample data (sample → population) can be modeled by resampling the sample data and performing inference on (resample → sample). As the population is unknown, the true error in a sample statistic against its population value is unknowable. In bootstrap-resamples, the 'population' is in fact the sample, and this is known; hence the quality of inference from resample data → 'true' sample is measurable.

{% highlight r %}
Yvar <- c(8,9,10,13,12, 14,18,12,8,9,   1,3,2,3,4)

#To generate a single bootstrap sample
sample(Yvar, replace = TRUE) 

#generate 1000 bootstrap samples
boot <-list()
for (i in 1:1000) 
   boot[[i]] <- sample(Yvar,replace=TRUE)        
{% endhighlight %}

Here we resample the data with replacement, and **the size of the resample must be equal to the size of the original data set**.

# Parametric bootstrap

A parametric model is fitted to the data, often by maximum likelihood, and samples of random numbers are drawn from this fitted model. Usually the sample drawn has the same sample size as the original data. Then the quantity, or estimate, of interest is calculated from these data. This sampling process is repeated many times as for other bootstrap methods. The use of a parametric model at the sampling stage of the bootstrap methodology leads to procedures which are different from those obtained by applying basic statistical theory to inference for the same model. The following is parametric bootstrap with normal distribution assumption with mean and standard deviation parameters.

{% highlight r %}
Yvar <- c(8,9,10,13,12, 14,18,12,8,9,   1,3,2,3,4)

# parameters for Yvar 
mean.y <- mean(Yvar)
sd.y <- sd(Yvar)

#To generate a single bootstrap sample with assumed normal distribution (mean, sd)
rnorm(length(Yvar), mean.y, sd.y)

 #generate 1000 bootstrap samples
boot <-list()
for (i in 1:1000) 
   boot[[i]] <- rnorm(length(Yvar), mean.y, sd.y)
{% endhighlight %}

In multivariate problems, case resampling refers to the simple scheme of resampling individual cases - often rows of a data set in regression problems, the explanatory variables are often fixed, or at least observed with more control than the response variable. Also, the range of the explanatory variables defines the information available from them. Therefore, to resample cases means that each bootstrap sample will lose some information. So it will be logical to sample rows of the data rather just Yvar.

{% highlight r %}
Yvar <- c(8,9,10,13,12, 14,18,12,8,9,   1,3,2,3,4)
Xvar <- c(rep("A", 5),  rep("B", 5),    rep("C", 5))
mydf <- data.frame (Yvar, Xvar)    

boot.samples <- list()
for(i in 1:10) {
   b.samples.cases <- sample(length(Xvar), length(Xvar), replace=TRUE) 
   b.mydf <- mydf[b.samples.cases,] 
   boot.samples[[i]] <- b.mydf
}
str(boot.samples)
boot.samples[1]
{% endhighlight %}

# Jacknife

The jackknife estimator of a parameter is found by systematically leaving out each observation from a dataset and calculating the estimate and then finding the average of these calculations. Given a sample of size N, the jackknife estimate is found by aggregating the estimates of each N − 1 estimate in the sample. The following shows how to jackknife the Yvar.

{% highlight r %}
jackdf <- list()
jack <- numeric(length(Yvar)-1)

for (i in 1:length (Yvar)){

for (j in 1:length(Yvar)){
     if(j < i){ 
            jack[j] <- Yvar[j]
}  else if(j > i) { 
             jack[j-1] <- Yvar[j]
}
}
jackdf[[i]] <- jack
}
jackdf
{% endhighlight %}

# Permutation test

A permutation test is a type of statistical significance test in which the distribution of the test statistic under the null hypothesis is obtained by calculating all possible values of the test statistic under rearrangements of the labels on the observed data points. Permutation tests exist for any test statistic, regardless of whether or not its distribution is known. Thus one is always free to choose the statistic which best discriminates between hypothesis and alternative and which minimizes losses.

**The difference between permutation and bootstrap is that bootstraps sample with replacement, and permutations sample without replacement.**  

The permutations always have all of the same observations, so they are more like the original data than bootstrap samples. The expectation is that the permutation test should be more sensitive than a bootstrap test. The permutations destroy volatility clustering but do not add any other variability.

The bootstrap estimates the variability of the sampling process and works well for estimating confidence intervals. You can do a test of hypothesis this way but it tends to be less powerful than the permutation test for cases that the permutation test assumptions hold.

So to perform permutation in this case we can just change *replace = FALSE* in the above bootstrap example:

{% highlight r %}
Yvar <- c(8,9,10,13,12, 14,18,12,8,9,   1,3,2,3,4)
     #generate 1000 bootstrap samples
       permutes <-list()
    for (i in 1:1000) 
       permutes[[i]] <- sample(Yvar,replace=FALSE)
{% endhighlight %}

In case of more than one variable, just picking of the rows and reshuffling the order will not make any difference as the data will remain same. So we reshuffle the y variable.

{% highlight r %}
Yvar <- c(8,9,10,13,12, 14,18,12,8,9,   1,3,2,3,4)
Xvar <- c(rep("A", 5),  rep("B", 5),    rep("C", 5))
mydf <- data.frame (Yvar, Xvar)

 permt.samples <- list()
    for(i in 1:10) {
       t.yvar <- Yvar[ sample(length(Yvar), length(Yvar), replace=FALSE) ]
       b.df <- data.frame (Xvar, t.yvar) 
       permt.samples[[i]] <- b.df 
    }
    str(permt.samples)
    permt.samples[1]
{% endhighlight %}

# Cross Validation

The idea beyond cross validation is that models should be tested with data that were not used to fit the model. Cross validation is perhaps most often used in the context of prediction.

Cross-validation is a statistical method for validating a predictive model. Subsets of the data are held out for use as validating sets; a model is fit to the remaining data (a training set) and used to predict for the validation set. Averaging the quality of the predictions across the validation sets yields an overall measure of prediction accuracy.

One form of cross-validation leaves out a single observation at a time; this is similar to the jackknife. Another, K-fold cross-validation, splits the data into K subsets; each is held out in turn as the validation set. Cross validation is usually done with quantitative data. You can convert your qualitative (factor data) to quantitative someway to fit a linear model and test this model. The following is simple hold-out strategy where 50% of data is used for model prediction while rest is used for testing. Lets assume *Xvar* is also quantitative variable.

{% highlight r %}
Yvar <- c(8,9,10,13,12, 14,18,12,8,9,   1,3,2,3,4)
Xvar <- c(rep(1, 5),  rep(2, 5),    rep(3, 5))
mydf <- data.frame (Yvar, Xvar)

training.id <- sample(1:nrow(mydf), round(nrow(mydf)/2,0), replace = FALSE)
test.id <- setdiff(1:nrow(mydf), training.id)

# training dataset 
mydf.train <- mydf[training.id]

#testing dataset 
mydf.test <- mydf[test.id]
{% endhighlight %}

Unlike bootstrap and permutation tests the cross-validation dataset for training and testing is different. The following figure shows a summary of resampling in different methods.

![resampling](/assets/posts/bootstrap/resampling-methods.jpg)

Limitations

* Permutations: exchangeability (equal variance)
* Permutations: valid only when the null hypothesis is *no association*
* Bootstrap: bad for statistics that are not smooth functions of F

# Fonts:

* [](https://stats.stackexchange.com/questions/104040/resampling-simulation-methods-monte-carlo-bootstrapping-jackknifing-cross)
* [Overview of Randomization Tests](http://www.uvm.edu/~dhowell/StatPages/Randomization%20Tests/RandomizationTestsOverview.html#Lunneborg)
