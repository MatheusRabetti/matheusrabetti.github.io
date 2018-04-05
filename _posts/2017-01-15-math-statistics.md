---
layout: post
title: The Epistemology of Statistics - Run Away from the Cookbook
categories:
  - Statistics
description: How math and statistics are related and some key concepts in a data analysis
tags: [Statistics]
---


# Let's illustrate a common statistics class

“Here is a column of a couple of dozen numbers. From them, calculate the mean and standard deviation. 
When you are finished — it should take you a good fifteen to twenty minutes — report back to me.”

So goes the instruction in many, if not most or even all, undergraduate statistics courses across the land.
Running through endless examples of plugging numbers into calculators and pressing certain buttons.
So what if the students forget why they’ve done it?

This inertia is a quirk of human nature and is common in any field of instruction: its limitations are
overcome easily by all serious students. Far more restraining, however, are the pernicious effects of the belief
that statistics is a branch of mathematics.

# Statistics is not math

Statistics is not math; neither is probability. It is true that math has proven unreasonably effective
in understanding statistics, but it is not, or at least not the sole, language to describe its workings. 

That language is philosophical. Just think: statistics self-named purpose is to compile evidence to use in quantifying 
uncertainty in (self-selected) hypotheses. How this evidence bears on the hypotheses may be best described mathematically,
but why it does so cannot be. It also cannot be that because statistics uses so much math that it is math. 

To master probability and statistics requires mastering a great chunk of math. But we begin to go wrong when we 
mindlessly apply equations in inappropriate situations because of the allure of quantification. **Equations become a scapegoat!**

Philosophy sharpens the mind. It teaches us to recognize and eliminate sloppy thinking and writing,
two elements rife in our field.  If people spent more time thinking about what they are saying and doing, much error would be reduced or eliminated. 

I’ll give just one example:

## What is a confidence interval? 

Confidence intervals provide more information than point estimates. Confidence intervals for means are intervals constructed using a procedure that will contain the population mean a specified proportion of the time, typically either 95% or 99% of the time. These intervals are referred to as 95% and 99% confidence intervals respectively. An example of a 95% confidence interval is shown below:

$$
  72.85 < \mu < 107.15
$$

There is good reason to believe that the population mean lies between these two bounds of 72.85 and 107.15 since 95% of the time confidence intervals contain the true mean.

If repeated samples were taken and the 95% confidence interval computed for each sample, 95% of the intervals would contain the population mean. Naturally, 5% of the intervals would not contain the population mean. It is natural to interpret a 95% confidence interval as an interval with a 0.95 probability of containing the population mean. 

But ask your neighborhood statistician and you will hear words about “95% confidence”, about “long runs”, 
about “other experiments”, etc., etc. **These poorly chosen phrases are a bar to clear thinking**. 
He has concentrated on the math, making sure to divide by n minus one in the appropriate place, etc.,
and has not given any time to consider why the calculation exists.

## The case of p-value

The p-value is the most controversial and traumatic estimative. People throw away studies and force results just to obtain  a p-value less than 0,05. To discuss this The American Statistical Association gathered 26 experts to develop a consensus statement on statistical significance and p-values.

There was no disagreement over the misuse of the p-value and how bad can drive the science. P-values have become a litmus test for deciding which studies are worthy of publication. As a result, research that produces p-values that surpass an arbitrary threshold are more likely to be published, while studies with greater or equal scientific importance may remain in the file drawer, unseen by the scientific community.

Small wonder that students have trouble with statistical hypothesis testing. They may be trying to think. Because we are taught to follow a cookbook a big mess about this concept spread. The p-value was never intended to be a substitute for scientific reasoning.

This committee organized some principles in a statistical analysis.

> **The ASA statement’s Principle No. 2**: “P-values do not measure the probability that the studied hypothesis is true, or the probability that the data were produced by random chance alone.” 

The p-value cannot tell you if your hypothesis is correct. Instead, it’s the probability of getting results at least as extreme as the ones you observed, given that the null hypothesis is correct. More concise - the probability of your data given your hypothesis. 

That sounds tantalizingly similar to “the probability of your hypothesis given your data”, but they’re not the same thing, said Stephen Senn, a biostatistician at the Luxembourg Institute of Health. To understand why, consider this example. “Is the pope Catholic? The answer is yes,” said Senn. “Is a Catholic the pope? The answer is probably not. If you change the order, the statement doesn’t survive.”

Let's suppose a hypothesis test. I believe that testing a new layout on my website will make my users spend more time in my website.

<br/>
<p align="center">
	<strong>H0:</strong> User's default layout time >= User's new layout time <br>
	<strong>H1:</strong> User's default layout time < User's new layout time
</p>
<br/>
After calculating the mean for each experiment (default, new layout) I see a difference of 10 minutes more in the mean time per user for the new layout. So, the p-value will answer: The p-value is the probability of the new layout be 10 minutes more than the default layout, given that the user in default layout spend more time than the user in the new layout.

Another common error relationed to the p-value is supposing it tells the size of an effect, the strength of the evidence or the importance of a result. Yet despite all these limitations, p-values are often used as a way to separate true findings from spurious ones, and that creates perverse incentives.

When p-values are treated as a way to sort results into bins labeled significant or not significant, the vast efforts to collect and analyze data are degraded into mere labels. 

If there’s one takeaway from the ASA statement, it’s that p-values are not badges of truth and p < 0.05 is not a line that separates real results from false ones. They’re simply one piece of a puzzle that should be considered in the context of other evidence.

# Always have in mind

Statistics is all about understanding data – numbers with context and meaning. A computer can do all of the calculations and all of the numerical work with finding a mean, a standard deviation, and even a confidence interval (all things we do in statistics). But, only a person can tell you if the mean really describes the data set or what the confidence interval is actually telling us.

So, statistics is about taking the information we get from mathematics and interpreting it. You may look at the math behind the information, but only to get a better idea of how to make a decision. A statistician is critical by nature.
