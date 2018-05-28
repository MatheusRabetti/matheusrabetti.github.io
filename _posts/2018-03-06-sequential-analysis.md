---
layout: post
title: Sequential Hypothesis Testing
description: From signal monitoring and anomaly detection to A/B testing
categories: experimentation
tags: [experimentation]
---

As the world becomes ever more data-driven, the basic theory of hypothesis testing is being used by more people and in more contexts than ever before. This expansion has, however, come with a cost. The dominant Neyman-Pearson hypothesis testing framework is subtle and easy to unknowingly misuse. In this post, we’ll explore the common scenario where we would like to monitor the status of an ongoing experiment and stop the experiment early if an effect becomes apparent.

There are many situations in which it is advantageous to monitor the status of an experiment and terminate it early if the conclusion seems apparent. In business, experiments cost money, both in terms of the actual cost of data collection and in terms of the opportunity cost of waiting for an experiment to reach a set number of samples before acting on its outcome, which may have been apparent much earlier.

While these reasons for continuous monitoring and early termination of certain experiments are quite compelling, if this method is applied naively, it can lead to wildly incorrect analyses. 

# Sequential Sampling

Sequential sampling is a non-probabilistic sampling technique, initially developed as a tool for product quality control.  The sample size, $ n $, is not fixed in advanced, nor is the timeframe of data collection. The process begins, first, with the sampling of a single observation or a group of observations. These are then tested to see whether or not the null hypothesis can be rejected. If the null is not rejected, then another observation or group of observations is sampled and the test is run again. Each iteration return one of three results:

* Reject the null hypothesis (H0) in favor of the alternate hypothesis (H1) and stop,
* Keep the null hypothesis and stop,
* Fail to reach either conclusion and continue sampling.

A characteristic feature of sequential sampling is that the sample size is not set in advance, because you don’t know at the outset how many times you’ll be repeating the process. Although it sounds like the process could go on and on forever, sequential sampling usually ends up with smaller samples than traditional (set size) sampling. 

# Sequential Probability Ratio Test

A sequential probability ratio test (SPRT) is a hypothesis test for sequential samples developed by Abraham Wald more than a half century ago. SPRT is a statistical technique for binary hypothesis testing (helping to decide between two hypothesis H0 and H1) and extensively used for system monitoring and early annunciation of signal drifting. SPRT is very popular for quality control and equipment surveillance applications, in industries and areas requiring a highly sensitive, reliable and especially fast detection of degradation behavior and/or sensor malfunctions.

Conventional techniques for signal monitoring rely on simple tests, based, for example on control chart schemes with thresholds, mean values, etc, and are sensitive only to spikes exceeding some limits or abrupt changes in the process mean. They trigger alarms generally just before failures or only after the process drifted significantly. Tighter thresholds lead to high numbers of false alarms and relaxed thresholds result in high numbers of missed alarms. Moreover, these techniques can perform very poorly in the presence of noise. 

The popularity of using SPRT for surveillance applications derives from the following characteristics: 

* SPRT detects signal discrepancies at the earliest mathematically possible time after the onset of system disturbances and/or sensor degradations. This property results from the fact that SPRT examines the statistical qualities of the monitored signals and catches nuances induced by disturbances well in advance of any measurable changes in the mean values of the signals.

* SPRT examines successive observations of a discrete process and is very cheap to compute. Thus, it is perfectly adapted for real time analysis with streaming data flows.

* SPRT offers control over false-alarms (α) and missed-alarms (1−β) rates via user-defined parameters.

# Show me the numbers

![numbers](/assets/posts/sequential-test/show-me-numbers.png)

## The misuse

Let's analyze the following hypothesis test. Assume the data are drawn from the normal distribution, $ N(\theta, 1) $ with unknown mean θ and known variance $\sigma^2 = 1$. We wish to test the simple null hypothesis that θ=0 versus the simple alternative hypothesis that θ=1 at the α=0.05 level. By the Neyman-Pearson lemma, the most powerful test of this hypothesis rejects the null hypothesis when the likelihood ratio exceeds some critical value. In our normal case, it is well-known that this criterion is equivalent to $ \sum_{i = 1}^n X_i > \sqrt{n} z_{0.05} $ where $ z_{0.05} \approx 1.64 $ is the $1−0.05=0.95$ quantile of the standard normal distribution.

To model the ongoing monitoring of this experiment, we define a random variable $ N = \min \{n \geq 1 \| \sum_{i = 1}^n X_i > \sqrt{n} z_{0.05}\} $, called the stopping time. The random variable N is the first time that the test statistic exceeds the critical value, and the naive approach to sequential testing would reject the null hypothesis after N samples (when $ N < \infty $, of course).

The likelihood ratio (LR) is the ratio of probabilities for observing the sequence $ x_n $ under an alternate hypothesis H1, versus the null hypothesis H0. Let

$$  
\begin{align*}
\Lambda (x_1, \ldots, x_n)
    & = \frac{L(1; x_1, \ldots, x_n)}{L(0; x_1, \ldots, x_n)}
\end{align*} 
$$

be the likelihood ratio corresponding to our two hypotheses. The SPRT uses two thresholds, $0< a < 1 < b$, and continues sampling whenever $a < \Lambda (x_1, \ldots, x_n) < b $. When $ \Lambda (x_1, \ldots, x_n) \leq a$, we accept the null hypothesis, and when $b \leq \Lambda (x_1, \ldots, x_n)$, we reject the null hypothesis. We choose A and B by fixing the approximate level of the test, α, and the approximate power of the test, 1−β. With these quantities chosen, we use:

$$
\begin{align*}
a
    & = \frac{\beta}{1 - \alpha}, \textrm{and} \\
b
    & = \frac{1 - \beta}{\alpha}.
\end{align*}
$$

Here we use a Monte Carlo method to approximate the level of this naive sequential test. First we generate ten thousand simulations of such an experiment, assuming the null hypothesis that the data are $ N(\theta, 1) $ is true.

~~~ python
import numpy as np
from scipy import stats

n = 100
N = 10000

samples = stats.norm.rvs(size=(N, n))
~~~

Here each row of samples corresponds to a simulation and each column to a sample.

Now we calculate the proportion of these simulated experiments that would have been stopped before one thousand samples, incorrectly rejecting the null hypothesis.

~~~ python
alpha = 0.05
z_alpha = stats.norm.isf(alpha)

cumsums = samples.cumsum(axis=1)
ns = np.arange(1, n + 1)

np.any(cumsums > np.sqrt(ns) * z_alpha, axis=1).sum() / N
~~~

~~~
0.30909999999999999
~~~

Here, each row of cumsums corresponds to a simulation and each column to the value of the test statistic 

We see that the actual level of this test is an order of magnitude larger than the desired level of α=0.05. We would be **raising the false positivies to 31%**. To check that our method is reasonable, we see that if we always collect one thousand samples, we achieve a simulated level quite close to α=0.05.

~~~ python
(cumsums[:, -1] > np.sqrt(n) * z_alpha).sum() / N
~~~

~~~
0.051700000000000003
~~~

This simulation is compelling evidence that the naive approach to sequential testing is not correct.

For our hypothesis test α=0.05. The power of the naive test after n samples is

~~~ python
power = 1 - stats.norm.sf(z_alpha - 1 / np.sqrt(n))
beta = 1 - power

power
~~~

~~~
0.93880916378665569
~~~

Which gives the following values for a and b:

~~~ python
a = beta / (1 - alpha)
b = (1 - beta) / alpha

a, b
~~~

~~~
(0.06441140654036244, 18.776183275733114)
~~~

For our example, it will be benificial to rewrite the SPRT in terms of the log- likelihood ratio,

$$
\begin{align*}
\log a
    & < \log \Lambda (x_1, \ldots, x_n)
      < \log b.
\end{align*}
$$

It is easy to show that $ \log \Lambda (x_1, \ldots, x_n) = \frac{n}{2} - \sum_{i = 1}^n X_i $, so the SPRT in this case reduces to

$$
\begin{align*}
\frac{n}{2} - \log b
    & < \sum_{i = 1}^n X_i
      < \frac{n}{2} - \log a.
\end{align*}
$$

The logarithms of a and b are

~~~ python
np.log((a, b))
~~~

~~~
array([-2.74246454,  2.93258922])
~~~

We verify that this test is indeed of approximate level α=0.05 using the simulations from our previous Monte Carlo analysis.

~~~ python
np.any(cumsums >= ns / 2 - np.log(a), axis=1).sum() / N
~~~

~~~
0.036299999999999999
~~~

## The saving

Let's gather some numbers to show the advantages of sequential testing. The tables below are from [Evan Miller's website](https://www.evanmiller.org/sequential-ab-testing.html).

The “Savings” column represents the percent reduction in sample size when comparing the sequential test under the alternative to the fixed-sample test.

| Significance α | Power 1−β | Lift |N | Savings |
|:--------------:|:---------:|:----:|-:|:-------:|
| 0.05       | 0.8    | 50%  | 170  | -13.9%  |
|            |        | 20%  | 808  | **10.0%**   |
|            |        | 10%  | 2922 | **17.4%**   |
| 0.01       | 0.8    | 50%  | 262  | -17.4%  |
|            |        | 20%  | 1272 | **6.2%**    |
|            |        | 10%  | 4644 | **13.3%**   |

The sequential-test figures compare favorably to the fixed-sample numbers in some circumstances (bold) and less favorably in other circumstances. The sequential test performs much better when an effect is present. It gives its strongest performance when detecting small lifts. For example, when the sample size has been chosen to detect a 10% lift, the expected "savings" under the alternative hypothesis are as high as 17.4%, but when detecting a very high (50%) lift, any savings are essentially wiped out, and it ends up requiring more observations than a fixed-sample test.

| Significance α | Power 1−β | Lift |N | Savings |
|:--------------:|:---------:|:----:|-:|:-------:|
| 0.05       | 0.8    | 50%  | 170  | **26.3%**  |
|            |        | 20%  | 808  | **46.9%**   |
|            |        | 10%  | 2922 | **53.2%**   |
| 0.01       | 0.8    | 50%  | 262  | **25.4%**  |
|            |        | 20%  | 1272 | **45.8%**    |
|            |        | 10%  | 4644 | **51.9%**   |

The sequential test comes into its own when the true effect is larger than the minimum detectable effect — i.e., when the treatment is a "blockbuster". The value of the sequential test now comes into greater focus: although a sequential test generally requires more observations than the equivalent fixed-sample test, it provides a kind of "early alert" for high-performing treatments. In settings where identifying a high-performing treatment is more urgent than reducing experiment times for low-performing treatments, the sequential test represents a compelling option. 

The savings are calculated assuming a 1% baseline conversion rate. The sequential test performs less efficiently at higher conversion rates.

# Fonts:

* [Process Anomalies - Oracle](https://blogs.oracle.com/r/early-detection-of-process-anomalies-with-sprt)
* [Uber Experimentation Platform](https://eng.uber.com/experimentation-platform/)
* [Sequential A/B Testing - Evan Miller](https://www.evanmiller.org/sequential-ab-testing.html)
