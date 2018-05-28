---
layout: post
title: Docker to Google Cloud
description: uhuul
categories: 
  - cloud
tags: [cloud]
---

# What is Docker?

A Docker container can be seen as a computer inside your computer. The cool thing about this virtual computer is that you can send it to your friends; And when they start this computer and run your code they will get exactly the same results as you did.

In short, you should use Docker because

* it allows you to **wrangle dependencies** starting from the operating system up to details such as R and Latex package versions
* it makes sure that your analyses are **reproducible**.
* **portability:** since a Docker container can easily be sent to another machine, you can set up everything on your own computer and then run the analyses on e.g. a more powerful machine on the cloud.

First things first: [install Docker](https://docs.docker.com/engine/getstarted/step_one/). The install guide links to a bunch of introductory material after installation is complete; it’s not necessary to complete those tutorials for this article, but they are an excellent introduction to basic Docker usage.

## Rstudio container

~~~ bash
docker pull rocker/rstudio
docker run --rm -p 8787:8787 --name rstudio -v ~/Documents/r-docker-tutorial:/home/rstudio/r-docker-tutorial rocker/rstudio
~~~

Optional: *-p*, *--rm*, *--name* and *-v* are flags that allow you to customize how you run the container. *p* tells Docker that you will be using a port to see RStudio in your web browser (at a location which we specify afterwards as port 8787:8787). Finally, *–rm* ensures that when we quit the container, the container is deleted. If we did not do this, everytime we run a container, a version of it will be saved to our local computer.

The *-v* flag links a volume (for example your local hard drive) to the container so that you can access the data there as well as being able to save things there.

Thus, you would enter ```http://localhost:8787``` in your browser as the url. This should lead to you being greeted by the RStudio welcome screen. Log in using:

username: rstudio password: rstudio

## Image with installed packages

But wait, what is going to happen when we exit the container? It will be deleted and since we didn’t save this version of the Docker image, when we open another instance of the container we will have to install all the packages again if we want to use it.

To avoid this, lets save the image by running ```docker commit``` and then the next time we run a Docker container we can run an instance of this image which includes the installed packages. To do this we need to open another terminal window before we close our Docker container.

To save this specific version of the image we need to find this containers specific hash. We can see this by typing the following command in the new terminal window, and it will list all running Docker containers:

~~~ bash
docker ps
~~~

Now to save this version of the image, in the new terminal window type:

~~~ bash
docker commit -m "rstudio + tidyverse packages" rstudio rstudio_tidyverse
~~~

~~~ bash
docker images 
docker tag bb38976d03cf yourhubusername/rstudio_tidyverse:firsttry
docker push yourhubusername/rstudio_tidyverse
~~~