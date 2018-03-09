---
layout: post
title: AB testing decision
categories:
  - Statistics
description: Handling uncertainty wisely
tags: [ab testing]
---

In Why Most Published Research Findings Are False John Ioannidis argues that if most hypotheses we test are false, we end up with more false research findings than true findings, even if we do rigorous hypothesis testing. The argument hinges on a vanilla application of Bayes’ rule. Lets assume that science is “really hard” and that only 50 out of 1000 hypotheses we formulate are in fact true. Say we test our hypotheses at significance level alpha=0.05 and with power beta=0.80. Out of our 950 incorrect hypotheses, our hypothesis testing will lead to 950x0.05 = 47.5 false positives i.e. false research findings. Out of our 100 correct hypotheses, we will correctly identify 50x0.8 = 40 true research findings. To our horror, we find that most published findings are false!

# Effects

A/B testing is not good for testing new experiences. It may result in change aversion (where users don’t like changes to the norm), or a novelty effect (where users see something new and test out everything).

The two things with new experiences is a) having a baseline and b) how much time needs to be allowed for the users to adapt to the new experience, so you can say what is going to be the plateaud experience and make a robust decision.

## The History Effect

The history effect is a big one – and it can happen when an event from the outside world skews your testing data. Let me explain…

Let’s say your company just closed a new round of funding and it’s announced publicly while you’re running a test. This might result in increased press coverage, which in turn results in an unusual traffic spike for your website.

The difference here is that a traffic spike that’s a direct result of an unusual event means there’s a high probability that those visitors differ from your usual, targeted traffic. In other words, they might have different needs, wants and browsing behaviours.

Now, because this traffic is only temporary, it means your test data could shift completely during this event and could result in making one of your variations win when in reality with your regular traffic, it should’ve lost.

How to avoid it skewing your tests

Maybe this is cliché, but the key to avoidance is prevention. If you’re aware of a major event coming up that could impact your test results, it’s a good idea not to test hypotheses and funnel steps that are likely to get affected.

For example, if you’re testing for a SaaS, and planning on getting a lot of unusual traffic for a week, emphasize on testing flows that only your existing users are seeing, when they’re logged-in, instead of testing the main portion of the website, such as tour/feature pages, pricing pages, etc.,

Be aware that you’ll always have traffic fluctuations and outside events that will affect your test data, it can never be completely avoided. In this case, the #1 thing you need to do to minimize the negative effect the History effect can have on your testing program, is to simply be aware of the fluctuations and differences in your traffic.

When you’re aware of what’s happening, you can dig deeper in Google Analytics to analyze your variations’ performance, and then recognize if your winning variation – is indeed a winner. Never analyze a test solely by using your testing tool.

# The Novelty Effect

This effect is more likely to come into play if a large portion of your traffic is coming from returning visitors rather than brand-new visitors (e.g. landing pages with paid traffic), so please be aware of it when making drastic changes to a webpage for a test…

Let me explain: The novelty effect happens when the engagement and interaction with one of your variations is substantially higher than previously, but only temporarily – giving you a false positive.

For example, if you launch a newly redesigned feature for your SaaS’ users and test it against the existing version, people will need to figure out how to use the new design. They’ll click around, spend more time figuring it out, and ultimately, can give the impression that your variation is performing better than is reality.

Truth is, there are still chances that in the long run, it will actually perform to a lesser degree, but that’s a result of your changes being novel for users during your testing period.

How to avoid it skewing your tests

Because the novelty effect is temporary, if you’re testing a variation that dramatically impacts your user’s flow, it is critical that you run your test for at least 4 weeks. In most cases 4 weeks will be enough time to start seeing the novelty wear off and the test results begin to regulate. 

If you have a variation that wins and you decide to implement it, be sure to keep tracking its performance in your analytics to ensure it’s long-term performance.


# Bayesian or Frequentist 

Which of these two statements is more appealing to your cenary:

1. "We rejected the null hypothesis that A = B with a p-value of 0.043"
2. "There is an 85% chance that A has a 5% lift over B."

Bayesian and Frequentist inference are defined by their goals not their methods.

* **The Goal of Frequentist Inference:** Construct procedure with frequency guarantees. For example, with a frequency of 95% of the times I replicate the sampling method the metric stays between *x* and *y* (confidence intervals).

* **The Goal of Bayesian Inference:** Quantify and manipulate your degrees of beliefs. In other words, Bayesian inference is the Analysis of Beliefs.

### Frequentist

A null hypothesis test produces a test statistic and a p-value, the probability of a test statistic as extreme as that of the data, under the assumption that the null hypothesis is true. 

That sounds similar to *the probability of your hypothesis given your data*. The p-value only tells us that the data fail to reach the extremity at which we'd be convinced a difference exists.

To start testing off on the right foot, we need to plan for an A/B test and perform a power calculation. This requires defining a hypothesis and test groups, and then considering two questions.

* False Positives: How sure do we need to be that we are measuring a real change?
	- What percentage of the time are we willing to miss a real effect? This is measured by power.
	- What percentage of the time are we willing to be fooled into seeing an effect by random chance? This is called significance level, and more precisely, we would state this as the probability of rejecting the null hypothesis.
* Effect Size: How big is the change we expect to see because of the new version, compared to the baseline?

Typical statistical standards for these quantities are 80% for power (i.e., 20% chance of a false negative) and 5% for significance level. Why are these standards used in practice? That’s a great question with a fair amount of baggage and tradition behind it. If we choose standards that are too strict, perhaps 95% for power and 1% for significance level, all our A/B tests will need to run longer and we will have to invest more time and resources into testing. We won’t be able to iterate quickly to solve our business problems. On the other hand, we’re not curing cancer here, right?! What if we relaxed these statistical standards? Then we risk making change after change in our product that does not improve anything, and investing work from our developers and other team members in changes that do not move us forward toward our goals. 

The effect size (practical significance) is the level of change that you would expect to see from a business standpoint for the change to be valuable. Estimating effect size requires strategic product thinking. You need to first understand how different areas of your product perform. In medicine, one would expect a 5,10 or 15% improvement for the result to be considered practically significant. At Google, for example, a 1-2% improvement in click through probability is practically significant. Understanding how each part of your funnel converts today helps you decide how big of an effect you’d need to see for the new change to be worth it. We use different questions to help estimate the effect size. How much development work is required to graduate the test? How strategically important is it? Does this feature support future plans? What is the size of audience or action are we optimizing for? These answers are detailed as success criteria in our test plans. 

# Metrics

At Google, it was observed that the analytical estimates of variance was often under-estimated, and therefore they have resorted to use empirical measurements based on A/A test to evaluate variance. If you see a lot of variability in a metric in an A/A test, it is probably too sensitive to be used.

1. Sensitivity and Robustness: Whether the metric is sensitive to changes you care about, and is robust to changes you don’t care about (e.g. mean is sensitive to outliers, median is robust but not sensitive to changes to small group of users). This can be measured by using prior experiments to see if the metric moves in a way that intuitively make sense. Another alternative is to do A/A tests to see if the metric picks up any spurious differences

2. Distribution: Obtained by doing a distribution on the retrospective data

# Sample and population

## Representative Sample

At globo.com the challenge to reach a sample size doesn't exist. A normal day expects 500 thousand users, so in less than a week we reach power and statistical significance to rollout any experimentation. However, as we are a product that mirrors television we have a very well settled product cycle. Let me explain the problem.

If you start a test on Monday and end it (with significance) on Friday, you didn’t account for weekend users and weekend users habits, which might be much different than any given day of the week.

The correct way to go about it is to pre-calculate your minimum needed sample size (no penalty for a bigger sample size ***), and testing for one (better still two) full business cycles – so the sample would include all weekdays, weekends, various sources of traffic, your blog publishing schedules, newsletters, phases of the moon, weather and everything else that might influence the outcome.

A solution: sample x users (first entry) by day to take all bussiness cycle and not expose our experimentation to more users than we want to. Letting us try more ideas in parallel and not over expose an in test idea **.

## Minimun Detectable Effect

In A/B testing, it is highly recommended to calculate your visitor sample size before testing. This advice comes from industrial testing practices and is important because it will define the cost of the experiment that we are looking to keep as low as possible.

This is what sample size calculators are used for. You are asked for the current success rate (conversion rate) and the size of the minimum effect to be measured. The result of the calculation is the size of the sample needed to conclude from such an experiment.

This transposes badly in the "digital area" for three main reasons:

* Measuring conversions costs nothing (unlike in the industry).
* The number of visitors is a part of the problem (not the answer).
* The effect of variation is difficult to predict (in practice this is precisely the question you are asking yourself!).

[mde](/assets/posts/ab-test/mde-sample-size.png)

Sample size translates directly into how long it takes to run a test.

## Proper Exposed Population

Don’t just launch a feature or set up an experiment, and wait for the magic to happen. In more cases than not, there will be no magic. This does not mean you are not awesome, but is a reminder that our job is hard. One area where I’ve seen countless teams struggle in experimentation is properly defining the exposed population. The exposed population defines who should see a feature and who should not, and is distinct from the exposure rate, which determines how much of the exposed population is going to be included in your experiment.

If you cannot accurately expose your experiment, make sure you have a way to identify the users who shouldn’t be in the experiment and drop them in the analysis stage. At Airbnb we do this by uploading an “exclusion table” to our experimentation pipeline, which includes all users that should be dropped from analysis due to improper exposure. Identifying these users can sometimes be incredibly onerous. If you are doing this work, make sure you share this with your partners as it is in the best interest of your whole team to understand data challenges and resolve them in scaleable ways.

# Extrapolating From Test Results

After a successful test, projections are often made regarding the additional revenue that will be generated in the future on the basis of test results. As a result, you see neat-looking management presentations, containing suggestions that a particular test concept will generate a plus in revenue of 40% in the next two years. Sounds great, but is that true?

To simply predict the result of a test linearly into the future does not work.

## Measuring Long-term Impact

A/B testing measures whether the concept leads to short term changes in customer behavior. The test runs three weeks and you see that the conversion rate increases by x%. So far, so good. However, this change does not say anything about the effect on long-term customer behavior and KPIs such as customer satisfaction and customer loyalty.

To be able to do so, the test would have to run far longer in order to record habituation effects or changes in the customer base and user needs. There’s also the novelty effect to be aware of. Users get used to novelties: what impresses us today is already merely habit tomorrow and is no longer strongly perceived.

Consequently, it is simply wrong to assume the measured short-term effect is a constant and project that holds for the future.

## Causality vs. correlation

Assume that the test showed a significant uplift and the test concept is to be solidly implemented. What often happens are so-called before-and-after comparisons, with the goal to find the measured effect in the conversion rate. Here, the conversion rate in the time period before the implementation is compared to a time period after the implementation. It is expected that the difference in the two rates must correspond exactly to the measured effect of the test. Well, usually it doesn’t.

Of course, changes that go live can lead to increases in the conversion rate. However, there are still hundreds of other influencing factors in parallel that also determine the conversion rate (e.g. season, sale events, delivery difficulties, new products, different customers or simply just bugs).

It is important to distinguish between causation and correlation. Correlation only states the extent to which two characteristic numbers follow a common trend. However, correlation says nothing about whether one characteristic number is causal, whether it is the origin of the change in the other variable.

The only possibility of measuring causal relationships and the effect of a test concept in the long term is the following: After a successful test you roll out the concept for 95% of your customers (for example through your testing tool). The remaining 5% is left as control group. By continuously comparing these two groups you can measure the long-term effect of your concept.

# Common statistics misinterpretation

## Confidence 

Assume a test shows an uplift of 4.5 % and a confidence level of 98%. That does not mean that the effect is 4.5 % with a probability of 98%! Every confidence analysis provides an interval that contains the expected uplift at a certain probability (confidence). That’s it.

In the example, this could mean that the effect based on the measured values ranges between 2% and 7% at a probability of 98%. It is therefore a fallacy to assume that the actual effect corresponds exactly to that of the test. This interval, however, does become smaller the longer the test runs, but it never arrives at an exact point estimate. 

Testing A with A with a confidence level of 95%, 5 on each 100 tests will be a success only by chance. Those are the false positives that we are trying to minimize. The confidence level simply gives an estimate about how stable the result is.

# New solutions

## Sequential Probability Ratio Test
