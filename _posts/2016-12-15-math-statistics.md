---
layout: post
title: The Epistemology of Statistics - Run Away from the Cookbook
categories:
  - Statistics
description: How math and statistics are related and some key concepts in a data analysis
tags: [Statistics]
---

# Statistics is not math

“Here is a column of a couple of dozen numbers. From them, calculate the mean and standard deviation. 
When you are finished — it should take you a good fifteen to twenty minutes — report back to me.”

So goes the instruction in many, if not most or even all, undergraduate statistics courses across the land.
Running through endless examples of plugging numbers into calculators and pressing certain buttons.
So what if the students forget why they’ve done it?

This inertia is a quirk of human nature and is common in any field of instruction: its limitations are
overcome easily by all serious students. Far more restraining, however, are the pernicious effects of the belief
that statistics is a branch of mathematics.

Statistics is not math; neither is probability. It is true that math has proven unreasonably effective
in understanding statistics, but it is not, or at least not the sole, language to describe its workings. 

That language is philosophical. Just think: statistics self-named purpose is to compile evidence to use in quantifying 
uncertainty in (self-selected) hypotheses. How this evidence bears on the hypotheses may be best described mathematically,
but why it does so cannot be. It also cannot be that because statistics uses so much math that it is math. 

To master probability and statistics requires mastering a great chunk of math. But we begin to go wrong when we 
mindlessly apply equations in inappropriate situations because of the allure of quantification. **Equations become a scapegoat!**

Philosophy sharpens the mind. It teaches us to recognize and eliminate sloppy thinking and writing,
two elements rife in our field. 
If people spent more time thinking about what they are saying and doing, much error would be reduced or eliminated. 

I’ll give just one example. What is a confidence interval? It is an equation, of course, 
that will provide you an interval for your data. It is meant to provide a measure of the uncertainty of a parameter estimate. 
Now, strictly according to frequentist theory the only thing you can say about the CI
you have in hand is that the true value of the parameter lies within it or that it does not. 
This is a tautology, therefore it is always true. Thus, the CI provides no measure of uncertainty at all. 

But ask your neighborhood statistician and you will hear words about “95% confidence”, about “long runs”, 
about “other experiments”, etc., etc. **These poorly chosen phrases are a bar to clear thinking**. 
They make the utterer forget that all he can say is some tautological, and therefore trivial, truth. 
He has concentrated on the math, making sure to divide by n minus one in the appropriate place, etc.,
and has not given any time to consider why the calculation exists.

# Test assumptions

The Welch t test makes a strange set of assumptions. What would it mean for two populations to have the same mean but different standard deviations? Why would you want to test for that? I prefer to think about the unequal variance t test as a way to create a confidence interval. Your prime goal is not to ask whether two populations differ, but to quantify how far apart the two means are. The unequal variance t test reports a confidence interval for the difference between two means that is usable even if the standard deviations differ.

# The case of p-value

The discussion quickly became heated, when the American Statistical Association gathered 26 experts to develop a consensus statement on statistical significance and p-values.

There was no disagreement over the misuse of the p-value and how bad can drive the science. P-values have become a litmus test for deciding which studies are worthy of publication. As a result, research that produces p-values that surpass an arbitrary threshold are more likely to be published, while studies with greater or equal scientific importance may remain in the file drawer, unseen by the scientific community.

Small wonder that students have trouble with statistical hypothesis testing. They may be trying to think. Because we are taught to follow a cookbook a big mess about this concept spread. The p-value was never intended to be a substitute for scientific reasoning.

> **The ASA statement’s Principle No. 2**: “P-values do not measure the probability that the studied hypothesis is true, or the probability that the data were produced by random chance alone.” 

The p-value cannot tell you if your hypothesis is correct. Instead, it’s the probability of getting results at least as extreme as the ones you observed, given that the null hypothesis is correct. More concise - the probability of your data given your hypothesis. That sounds tantalizingly similar to “the probability of your hypothesis given your data,” but they’re not the same thing, said Stephen Senn, a biostatistician at the Luxembourg Institute of Health. To understand why, consider this example. “Is the pope Catholic? The answer is yes,” said Senn. “Is a Catholic the pope? The answer is probably not. If you change the order, the statement doesn’t survive.”

Nor can a p-value tell you the size of an effect, the strength of the evidence or the importance of a result. Yet despite all these limitations, p-values are often used as a way to separate true findings from spurious ones, and that creates perverse incentives.

When p-values are treated as a way to sort results into bins labeled significant or not significant, the vast efforts to collect and analyze data are degraded into mere labels. 

If there’s one takeaway from the ASA statement, it’s that p-values are not badges of truth and p < 0.05 is not a line that separates real results from false ones. They’re simply one piece of a puzzle that should be considered in the context of other evidence.

# Always have in mind

Statistics is all about understanding data – numbers with context and meaning. A computer can do all of the calculations and all of the numerical work with finding a mean, a standard deviation, and even a confidence interval (all things we do in statistics). But, only a person can tell you if the mean really describes the data set or what the confidence interval is actually telling us.

So, statistics is about taking the information we get from mathematics and interpreting it. You may look at the math behind the information, but only to get a better idea of how to make a decision. The most important things I’ve learned in years of studying statistics and doind analysis aren’t formal, but have proven extremely useful when working/playing with data. 

### Attention to Detail

Oftentimes it’s the little things that end up being the most important. There was this one time in class when my professor put up a graph on the projector. It was a bunch of data points with a smooth fitted line. He asked what we saw. Well, there was an increase in the beginning, a leveling off in the middle, and then another increase. However, what I missed was the little blip in the curve in the first increase. That was what we were after.

The point is that trends and patterns are important, but so are outliers, missing data points, and inconsistencies.

### See the Big Picture

It’s important not to get too caught up with individual data points or a tiny section in a really big dataset. Always look on what the data wants to talk in general. Looking at distance, what can you see?

### No Agendas

This should go without saying, but approach data as objectively as possible. I’m not saying you shouldn’t have a hunch about what you’re looking for, but don’t let your preconceived ideas influence the results. Because if you go to length looking for some specific pattern, you’re probably going to find it. It’ll just be at the sacrifice of accurate results.

### Look Outside the Data

Context, context, context. Sometimes this will come in the form of metadata. Other times it’ll come from more data.

The more you know about how the data was collected, where it came from, when it happened, and what was going on at the time, the more informative your results and the more confident you can be about your findings.

### Ask Why

Finally, and this is the most important thing I’ve learned, always ask why. When you see a blip in a graph, you should wonder why it’s there. If you find some correlation, you should think about whether or not it makes any sense. If it does make sense, then cool, but if not, dig deeper. Numbers are great, but you have to remember that when humans are involved, errors are always a possibility.

