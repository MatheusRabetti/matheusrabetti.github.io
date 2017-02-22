---
layout: post
title: Passing arguments to an R script from command lines
categories:
  - Data Analysis
description: Shedule a job for your R script
tags: [Unix]
---

# Why is it necessary?

I developed a R script where it generate certain outputs for the trimester and year of interest.

The decision to choose which trimester and year should be done by the data engineers in the project as a store process.
So all the script had to be parameterized in function of trimesters and year so then it could scheduled 
as a task where these arguments are passed in a bash command. 

The automation process couldn't go into the R environment as the software in use didn't support.

# How is it done?

The function **commandArgs** scans the arguments which have been supplied when the current R session was invoked. 

The following code shows a simple example of two arguments been passed. Save it as args-script.R to try it as an example.

{% highlight r %}
options(echo = TRUE) 

args<-commandArgs(TRUE)

sprintf('Arg1: %s --- Arg2: %s', 
        args[1], args[2]')
        
{% endhighlight %}

To pass the arguments of trimester and year the command in the bash should be like this:

{% highlight text %}
Rscript myscript.R trimester year
{% endhighlight %}

The result in your R environment should be: "Arg1: trimester --- Arg2: year".

Just an observation. The R script have to be in the working directory you are in the Terminal.
