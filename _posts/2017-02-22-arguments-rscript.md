---
layout: post
title: Passing Arguments to an R Script from Command Lines
categories:
  - Data Analysis
description: Shedule a job for your R script
tags: [Unix]
---

# Why is it necessary?

Working along a data engineers team I got in a process where the definitions of the parameters that my R script would run should be done by a automated process doing job sequentialy. Ok, what does it means? 

It means that it wasn't enough to write a beautiful functional code. I needed to write a functional code that the arguments that my functions would call were external off my R script ambient. Basically the arguments were the *trimester* and *year*.

So all the script had to be parameterized in function of *trimesters* and *year* so then it could scheduled 
as a task where these arguments are passed in a bash command.

So, at first, I developed a R script where it generate certain outputs for the *trimester* and *year* of interest. Later I found a solution to parse arguments from a bash command to my Rscript run.

# How is it done?

The function *commandArgs* scans the arguments which have been supplied when the current R session was invoked. 

The following code shows a simple example of two arguments been passed. Save it as *args-script.R* to try it as an example.

{% highlight r %}
#! /usr/bin/env Rscript

options(echo = TRUE)

args<-commandArgs(TRUE)

sprintf('Arg1: %s --- Arg2: %s', 
        args[1], args[2]')
        
{% endhighlight %}

Now go to your terminal and type **chmod +x myscript.R** to give the file execution permission. Then, execute your first script by typing **./myscript.R** on the terminal. You should see
To pass the arguments of trimester and year the command in the bash should be like this:

{% highlight text %}
Rscript myscript.R trimester year
{% endhighlight %}

The result in your R environment should be: **"Arg1: trimester --- Arg2: year"**.

The first line of the R code is telling the Terminal to use Rscript to execute the .R file. So you it isn't necessary the Rscript on the bash command.

# Pipeline

Along this particular usage it can be an amazing tool when we need to work in large projects where different parts of the project needs to be implemented using different languages that are later glued together to form the final product.

With the wealth of distinct library resources provided by each language, there is a growing need for data scientists to be able to leverage their relative strengths. 

Python tends to outperform R in such areas as:

* **Web scraping and crawling:** though *rvest* has simplified web scraping and crawling within R, Python’s *beautifulsoup* and *Scrapy* are more mature and deliver more functionality.
* **Database connections:** though R has a large number of options for connecting to databases, Python’s *sqlachemy* offers this in a single package and is widely used in production environments.

Whereas R outperforms Python in such areas as:

* **Statistical analysis options:** though Python’s combination of *Scipy*, *Pandas* and *statsmodels* offer a great set of statistical analysis tools, R is built specifically around statistical analysis applications and so provides a much larger collection of such tools.
* **Interactive graphics/dashboards:** *bokeh*, *plotly* and *intuitics* have all recently extended the use of Python graphics onto web browsers, but getting an example up and running using *shiny* and *shiny* dashboard in R is faster, and often requires less code.

Further, as data science teams now have a relatively wide range of skills, the language of choice for any application may come down to prior knowledge and experience. For some applications – especially in prototyping and development – it is faster for people to use the tool that they already know.

It is extremely useful to be able to take advantage of pipeline capabilities of the form:

{% highlight text %}

cat file.txt | preProcessInPython.py | runRmodel.R | formatOutput.sh > output.txt

{% endhighlight %}


# More about
[Thiago's Blog](https://tgmstat.wordpress.com/2014/05/21/r-scripts/)
