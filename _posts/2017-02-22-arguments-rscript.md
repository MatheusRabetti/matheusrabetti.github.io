---
layout: post
title: Passing Arguments to an R Script from Command Lines
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

Along this particular usage it can be ana amazing tool when we need to work in large projects where different parts of the project needs to be implemented using different languages that are later glued together to form the final product.

# How is it done?

The function **commandArgs** scans the arguments which have been supplied when the current R session was invoked. 

The following code shows a simple example of two arguments been passed. Save it as args-script.R to try it as an example.

{% highlight r %}
#! /usr/bin/env Rscript

options(echo = TRUE)

args<-commandArgs(TRUE)

sprintf('Arg1: %s --- Arg2: %s', 
        args[1], args[2]')
        
{% endhighlight %}

Now go to your terminal and type chmod +x myscript.R to give the file execution permission. Then, execute your first script by typing ./myscript.R on the terminal. You should see
To pass the arguments of trimester and year the command in the bash should be like this:

{% highlight text %}
Rscript myscript.R trimester year
{% endhighlight %}

The result in your R environment should be: **"Arg1: trimester --- Arg2: year"**.

The first line of the R code is telling the Terminal to use Rscript to execute the .R file. So you it isn't necessary the Rscript on the bash command.

# Pipeline

It is extremely useful to be able to take advantage of pipeline capabilities of the form:

{% highlight text %}

cat file.txt | preProcessInPython.py | runRmodel.R | formatOutput.sh > output.txt

{% endhighlight %}


# More about
https://tgmstat.wordpress.com/2014/05/21/r-scripts/
