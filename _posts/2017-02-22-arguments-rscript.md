---
layout: post
title: Integrating R, Python and Bash to Build a Job 
categories:
  - Data Analysis
description: Passing arguments on command line and piping scripts
tags: [Unix]
---

# Integrating R and Bash
## Passing arguments outside the script

In the world of data analysis, the term automation runs hand in hand with the term “scripting”. There’s not the best programming language, only the most suitable to perform the required function.

Working along a data engineers team I got in a process where the definitions of the parameters that my R script should run would be done by a automated process doing job sequentialy. Ok, what does it means? 

It means that it wasn't enough to write a beautiful functional code. I needed to write a functional code where the arguments that my functions would call were external off my R script ambient. To simplify, the arguments were the *trimester* and *year*.

All the script had to be parameterized in function of *trimesters* and *year*. After parametizing the script it could scheduled as a task where these arguments are passed in a bash command.

At first, I developed a R script where it generate certain outputs for the *trimester* and *year* of interest. Later I found a solution to parse arguments from a bash command to my Rscript run.

## How is it done?

The function *commandArgs* scans the arguments which have been supplied when the current R session was invoked. 

The following code shows the simple example with two arguments been passed. Save it as *args-script.R* to try it as an example.

{% highlight r %}
#! /usr/bin/env Rscript

options(echo = TRUE)

args <- commandArgs(TRUE)

sprintf('Arg1: %s --- Arg2: %s', 
        args[1], args[2]')
        
{% endhighlight %}

To pass the arguments of trimester and year the command in the bash should be like this:

{% highlight text %}
Rscript myscript.R trimester year
{% endhighlight %}

The result in your R environment should be: **"Arg1: trimester --- Arg2: year"**.

The first line (hashtagged) of the R code is telling the Terminal to use Rscript to execute the .R file. On terminal type **chmod +x myscript.R** to give the file execution permission. Then, execute your first script by typing **./myscript.R** on the terminal. So it isn't necessary the *Rscript* command on the bash command.

# Integrating R, Python and Bash

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

# Quick example

I have a text file that cointains two columns:

* School name
* School grade

To get the average and the standard deviation of the school's grade I wrote a Python script which prints those results. In R I read those parameters and made a more elegant print. Sorry, no models ... but this process can become a beautiful tool.

The workflow will look like this:
<br/>
<br/>
![workflow](/assets/posts/integrate-r-python/workflow.png)
<br/>
Let's show all the steps inside:

### The text file

{% highlight text %}

cat school-grade.txt

{% endhighlight %}

{% highlight text %}

school,rate
"sigma",10
"central",20
"john",50
"militar",5
"up",30

{% endhighlight %}

### The Python Script

{% highlight python %}

import sys
import pandas as pd

df = pd.read_csv(sys.stdin)

school_rate_mean = df['rate'].mean()
school_rate_std = df['rate'].std()

print "%s,%s" % (school_rate_mean,school_rate_std)

{% endhighlight %}

The Python script reads into *pandas* the stdin of the *cat school-rate.txt* and print a string with the average and the standar deviation.

{% highlight text %}

cat school-grade.txt | python mean-std.py

{% endhighlight %}

The result is the string: **23.0,17.88854382**

### The R Script

{% highlight r %}

#!/usr/bin/env Rscript
f <- file("stdin")
open(f)

# Read the string
string = readLines(f)
# Split the string by the "," and create a vector with two parameters 
vector = strsplit(string, split = ",")[[1]]
cat(sprintf("Mean = %s \nStandard Deviation = %s\n", vector[1], vector[2]))

{% endhighlight %}

The R script reads the string Python generated and makes a clean print.

{% highlight text %}

cat school-grade.txt | python mean-std.py | Rscript read_argument.r

{% endhighlight %}

The result is:
<br/>
**Mean = 23.0**

**Standard Deviation = 17.88854382**

# More about
[Thiago's Blog](https://tgmstat.wordpress.com/2014/05/21/r-scripts/)
