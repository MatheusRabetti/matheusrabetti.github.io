---
layout: post
title: Using Unix Commands for Data Science
description: How can unix commands on terminal helps on analysing data
categories:
  - Data Analysis
tags: [Unix,Big Data]
---

# The Amazing Unix Shell

Hilary Mason and Chris Wiggins wrote about the importance of any data scientist being familiar with the command line. So...
it's enough to you start it! Often people use Hadoop and other so-called Big Data tools for real-world processing and analysis jobs that can be done faster with simpler tools and different techniques.

One especially under-used approach for data processing is using standard shell tools and commands. The benefits of this approach can be massive, since creating a data pipeline out of shell commands means that all the processing steps can be done in parallel. You can pretty easily construct a stream processing pipeline with basic commands that will have extremely good performance compared to many modern Big Data tools.

An additional point is the batch versus streaming analysis approach. Getting short on memory. This is because all data is loaded into RAM for the analysis. However, considering the problem for a bit, it can be easily solved with streaming analysis that requires basically no memory at all. The resulting stream processing pipeline we will create will be over faster than the Hadoop implementation and use virtually no memory.

The command line is essential to my daily work, so I wanted to share some of the commands I've found most useful.

Here you'll see some nice commands on the Unix shell from basic information on the data to analysis.

## General syntax

Pipe | ``` result | use result ``` | The next command will use the previous result | 
Save | ``` result > file.txt ``` | Save the result in a file |
Stop | **Control+C** | Stops running the command |
Help | ``` head --help ``` | Explanation and parameters overview |

## Data

The [dataset](https://vincentarelbundock.github.io/Rdatasets/doc/car/Salaries.html) is the 2008-09 nine-month academic salary for Assistant Professors, Associate Professors and Professors in a college in the U.S. 

To reproduce this post download the file and unzip it using the commands below.

~~~ bash
$ cd ~/Downloads/
$ wget 'https://vincentarelbundock.github.io/Rdatasets/csv/car/Salaries.csv'
~~~

## Head & Tail - First look

Sometimes you just need to inspect the structure of a huge file. That's where *head* and *tail* come in. 
*Head* prints the first ten lines of a file, while *tail* prints the last ten lines. 
Optionally, you can include the -n parameter to change the number of lines displayed.

{% highlight bash %}
$ head -n 3 Salaries.csv
{% endhighlight %}

{% highlight text %}
"","rank","discipline","yrs.since.phd","yrs.service","sex","salary"
"1","Prof","B",19,18,"Male",139750
"2","Prof","B",20,16,"Male",173200
{% endhighlight %}

{% highlight bash %}
$ tail -n 3 Salaries.csv
{% endhighlight %}

{% highlight text %}
"395","Prof","A",42,25,"Male",101738
"396","Prof","A",25,15,"Male",95329
"397","AsstProf","A",8,4,"Male",81035
{% endhighlight %}

## Cut - Column extracter

Unix command *cut* is used for text processing.
You can use this command to extract portion of text from a file by selecting columns.

{% highlight bash %}
$ cut -d',' -f2,4,6,7 Salaries.csv | head -n4
{% endhighlight %}

{% highlight text %}
"rank","yrs.since.phd","sex","salary"
"Prof",19,"Male",139750
"Prof",20,"Male",173200
"AsstProf",4,"Male",79750
{% endhighlight %}

## Iconv - File encoding

The *iconv* program converts the encoding of characters in inputfile from one coded character set to another. The file encoding is all right so let's create a problem:

~~~ bash
$ echo 'pão' > new.txt
$ cat new.txt
~~~

~~~ bash
pão
~~~

UTF-8 handles the *ã* character well. But if we set as ISO-8859-9?

~~~ bash
$ cat new.txt | iconv -f UTF-8 -t ISO-8859-9
~~~

~~~ bash
p�o
~~~

A wild � appears! For the sake of curiosity, *pão* is bread in Portuguese.

If I have a bunch of text files that I'd like to convert from any given charset to UTF-8 encoding. Just use this bash magic.

{% highlight bash %}
$ for file in *.txt; do iconv -f ascii -t utf-8 $file; done
{% endhighlight %}

## Sort - Ordering

*Sort* is a simple and very useful command which will rearrange the lines in a text file so that they are sorted, numerically and alphabetically. 
Here is the top five salaries.

{% highlight bash %}
$ cut -d',' -f7 Salaries.csv | sort -n -r | head -n5
{% endhighlight %}

{% highlight text %}
 231545
 205500
 204000
 194800
 193000
{% endhighlight %}

## WC - word count 

By default, *wc* will quickly tell you how many lines, words, and bytes are in a file. 
If you're looking for just the line count, you can pass the -l parameter in.
I use it most often to verify record counts between files or database tables throughout an analysis.

{% highlight bash %}
$ wc -l Salaries.csv
{% endhighlight %}

{% highlight text %}
398 Salaries.csv
{% endhighlight %}

## Unique - Distinct entries

Sometimes you want to check for duplicate records in a large text file - that's when *uniq* comes in handy. By using the -c parameter, uniq will output the count of occurrences along with the line. You can also use the -d and -u parameters to output only duplicated or unique records.

{% highlight bash %}
$ cut -d',' -f6 Salaries.csv | sort | uniq -c
{% endhighlight %}

{% highlight text %}
  39 "Female"
 358 "Male"
   1 "sex"
{% endhighlight %}

Count the number of unique lines.

{% highlight bash %}
$ sort Salaries.csv | uniq -u | wc -l
$ wc -l Salaries.csv
{% endhighlight %}

{% highlight text %}
398
398 Salaries.csv
{% endhighlight %}


## Grep - Find pattern

*Grep* allows you to search through plain text files using regular expressions. 
There's an assortment of extra parameters you can use with *grep*, but the ones I tend to use the most are -i (ignore case),
-r (recursively search directories), -B N (N lines before), -A N (N lines after).

{% highlight bash %}
$ cut -d',' -f3 Salaries.csv |head -n4 | grep B
{% endhighlight %}

{% highlight bash %}
"B"
"B"
"B"
{% endhighlight %}

In case I want to find a entry in the first column that don't starts with *"Prof*:

{% highlight bash %}
$ cut -d',' -f2 Salaries.csv | head -n10 | grep '[^"Prof].*'
{% endhighlight %}

{% highlight text %}
"rank"
"AsstProf"
"AssocProf"
{% endhighlight %}

## Sed

Sed is similar to grep and awk (next) in many ways, however I find that I most often use it when needing to do some find and replace magic on a very large file. 

*  ```s``` is used to replace the found expression.
*  ```g``` stands for *global*, meaning to do this for the whole line. If you leave off the g and the expression appears twice on the same line, only the first is changed.
*  ```-i``` option is used to edit in place on filename.
*  ```-e``` option indicates a command to run.

I will substitute the *Male* entries for a single char *M*:

{% highlight bash %}
$ cut -d',' -f6 Salaries.csv | head -n4 | sed -e 's/"Male"/"M"/g'
{% endhighlight %}

{% highlight text %}
"sex"
"M"
"M"
"M"
{% endhighlight %}

## AWK - Powerful

### Sum

How much is the annual cost of teachers in this school?

{% highlight bash %}
$ cat Salaries.csv | awk -F "," '{sum += $7} END {printf "%.0f\n", sum}'
{% endhighlight %}

{% highlight text %}
45141464
{% endhighlight %}

The above line says:

1.  Use the cat command to stream (print) the contents of the file to stdout.
2.  Pipe the streaming contents from our cat command to the next one - awk.
3.  With awk:
    1. Set the field separator to the pipe character (-F ","). 
    2. Increment the variable sum with the value in the twelfth column ($7). Since we used a pipeline in point #2,
    the contents of each line are being streamed to this statement.
    3. Once the stream is done, print out the value of sum, using printf to format the value with none decimal places.

### List the column number

The next command is essential to manipulate a data with many columns.

{% highlight bash %}
$ awk 'BEGIN {FS=","} {for(fn=1;fn<=NF;fn++) {print fn" = "$fn;}; exit;}' Salaries.csv
{% endhighlight %}

{% highlight text %}
1 = ""
2 = "rank"
3 = "discipline"
4 = "yrs.since.phd"
5 = "yrs.service"
6 = "sex"
7 = "salary"
{% endhighlight %}

### Char count

This command counts the maximum character length of each column in *Salaries.csv* file. Very nice command to look at your data and parse correctly the text file to a database:


{% highlight bash %}
$ tail -n10000 Salaries.csv | awk -F',' 'NR > 1 {for (i=1; i <= NF; i++) max[i] = (length($i) > max[i]?length($i):max[i])}
             END {for (i=1; i <= NF; i++) printf "%d%s", max[i], (i==NF?RS:FS)}'
{% endhighlight %}             
             
{% highlight text %}
5,11,3,2,2,8,6
{% endhighlight %}

### Mean

It makes possible to calculate the mean of the whole file. 
In the below example I want the average salary for the female professors.


{% highlight bash %}
$  awk -F',' '($6) ~ /Female/ {sum+=$7; count+=1} END {print sum/count}' Salaries.csv
{% endhighlight %}

{% highlight text %}
101002
{% endhighlight %}

### Standard Deviation - population

Also, *awk* can bring some position measures like the standard deviation.

{% highlight bash %}
$ awk -F',' 'pass==1 {sum+=$7; n+=1} pass==2 {mean=sum/n; 
     ssd+=($1-mean)*($1-mean)} END {print sqrt(ssd/n)}' pass=1 Salaries.csv pass=2 Salaries.csv
{% endhighlight %}

{% highlight text %}
113421
{% endhighlight %}

### Split file by some rule

You can also split your file filtered by a rule. 

{% highlight bash %}
$ gawk -F',' '{x=($6 ~ "Female")?"salaries-female.txt":"salaries-male.txt"; print > x}' Salaries.csv
{% endhighlight %}

### Dive Deeper

* [AWK in 20 minutes](http://ferd.ca/awk-in-20-minutes.html)
* [Command line tools vs Hadoop](http://aadrake.com/command-line-tools-can-be-235x-faster-than-your-hadoop-cluster.html)
