---
layout: post
title: Machiner Learning for Big Data
categories:
  - Machine Learning
description: SVM linear implementation on stochastic gradient descent
tags: [machine learning]
---

## Main ways to train a machine learning model

There are three popular ways to train a model: batch learning, mini-batch learning, and stochastic learning.

* **Batch Learning :** In the first mode, we store all the training data in an array and feed it to the algorithm, reducing the loss function based on all the examples at once. This is not always possible due to the size of the dataset. In these cases we have to resort to the two other ways.
* **Mini-Batch Learning :** In this case, we select a N number of examples and divide the training set into blocks of this size. So we train the model in one block at a time.
* **Stochastic learning :** this is a variation of the mini-batch, but with N = 1. We use only one example at a time to train the model. This is the preferred mode in big data solutions.

And we have two main divisions:

* **Offline :** In this case we have all the data stored in a database, but it does not fit in memory, so we need to train on one example (or batch) at a time.
* **Online :** In this case we receive the examples in real time, we train and we discard, without the need to store them.

In addition to not having to load all the data in memory to train the model, in some cases, using algorithms that train on one example at a time may be faster than the format that uses all the data at the same time.


## Support Vector Machine - SVM

There are multiple ways to classify data with machine learning. You could run a logistic regression, use decision trees, or build a neural network to accomplish the task. In 1963, Vladimir Vapnik and Alexey Chervonenkis developed another classification tool, the support vector machine. Vapnik refined this classification method in the 1990’s and extended uses for SVMs. Support vector machines have become a great tool for the data scientist and is my choice in this exercise.

SVMs try to find a hyperplane, which maximizes the margin between two classes. The margin is the distance between the hyperplane and a few close points. These close points are the support vectors because they control the hyperplane.

## Stochastic Gradient Descent

To start explaning from scratch a for dummy concept helps. 

Lets say you are about to start a business that sells t-shirts, but you are unsure what are the best measures for a medium sized one for males. Luckily you have gathered a group of men that have all stated they tend to buy medium sized t-shirts. Now you figure you're going to use a gradient descent type method t get the size just right.

#### Batch Gradient Descent
1. Tailor makes initial estimate.
2. Each person in the batch gets to try the t-shirt and write down feedback.
3. Collect and summarize all feedback.
4. If the feedback suggests a change, let the tailor adjust the t-shirt and go to 2.

#### Stochastic Gradient Descent
1. Tailor makes initial estimate.
2. A random guy (or a subset of the full group) tries the t-shirt and gives feedback.
3. Make a small adjustment according to feedback.
4. While you still have time for this, go to 2.

#### Highlighting the differences

* Batch gradient descent needs to collect lots of feedback before making adjustments, but needs to do fewer adjustments.
* Stochastic gradient descent makes many small adjustments, but spends less time collecting feedback in between.
* Batch gradient descent preferable if the full population is small, stochastic gradient descent preferable if the full population is very large.
* Batch gradient descent methods can be made parallel if you have access to more hardware (in this case, more tailors and materials) as you can collect all feedback in parallel.
* Stochastic gradient descent does not readily lend itself to parallelization as the you need the feedback from one iteration to proceed with the next iteration.

A gradient is the ratio by which a variable quantity increases or decreases. The adjusments according to the feedback are this variation. The feedback can be de error function. The gradient of a scalar function is the co-vector with the direction according to which the highest rate of change of function occurs. Its modulus is equal to the rate of function variation along that direction.

In both batch gradient descent (GD) and stochastic gradient descent (SGD), you update a set of parameters in an iterative manner to minimize the error function.

While in GD, you have to run through **all** the samples in your training set to do a single update for a parameter in a particular iteration, in SGD, on the other hand, you use **only one** training sample from your training set to do the update for a parameter in a particular iteration.

Thus, if the number of training samples are large, in fact very large, then using gradient descent may take too long because in every iteration when you are updating the values of the parameters, you are running through the complete training set. On the other hand, using SGD will be faster because you use only one training sample and it starts improving itself right away from the first sample.

That difference explains the stochastic process, instead of describing the system through deterministic equations, that given an initial condition, we know all the evolution of the system, we will use stochastic processes, for which, given an initial condition, we still have several possible trajectories evolution of the system.

SGD minimizes a function by following the gradients of the cost function. 

### Calculating the Error 

To calculate the error of a prediction we first need to define the objective function of the svm. 

#### Hinge Loss Function

To do this, we need to define the loss function, to calculate the prediction error. We will use hinge loss! 

The hinge loss is a loss function used for training classifiers. The hinge loss is used for "maximum-margin" classification.

$$c(x, y, f(x)) = (1 - y * f(x))_+$$

$c$ is the loss function, $x$ the sample, $y$ is the true label, $f(x)$ the predicted label.

This means the following:
$$
c(x, y, f(x))= 
\begin{cases}
    0,& \text{if } y*f(x)\geq 1\\
    1-y*f(x),              & \text{else}
\end{cases}
$$

So consider, if y and f(x) are signed values $(+1,-1)$:

<ul>
    <li>the loss is 0, if $y*f(x)$ are positive, respective both values have the same sign.</li>
    <li>loss is $1-y*f(x)$ if $y*f(x)$ is negative</li>
</ul>

#### Objective Function 

As we defined the loss function, we can now define the objective function for the svm:

$$\underset{w}{min}\ \lambda\parallel w\parallel^2 + \ \sum_{i=1}^n\big(1-y_i \langle x_i,w \rangle\big)_+$$

As you can see, our objective of a svm consists of two terms. The first term is a regularizer, the second term the loss. The regularizer parameter $\lambda$ determines the tradeoff between increasing the margin-size and ensuring that the $x_i$ lie on the correct side of the margin balancing margin maximization and loss.

#### Derive the Objective Function

To minimize this function, we need the gradients of this function.

As we have two terms, we will derive them seperately using the sum rule in differentiation.

$$
\frac{\delta}{\delta w_k} \lambda\parallel w\parallel^2 \ = 2 \lambda w_k
$$

$$
\frac{\delta}{\delta w_k} \big(1-y_i \langle x_i,w \rangle\big)_+ \ = \begin{cases}
    0,& \text{if } y_i \langle x_i,w \rangle\geq 1\\
    -y_ix_{ik},              & \text{else}
\end{cases}
$$

This means, if we have a misclassified sample $x_i$, respectively $y_i \langle x_i,w \rangle \ < \ 1$, we update the weight vector w using the gradients of both terms, if $y_i \langle x_i,w \rangle \geq 1$ we just update w by the gradient of the regularizer. To sum it up, our stochastic gradient descent for the svm looks like this:

if $y_i⟨x_i,w⟩ < 1$:
$$
w = w + \alpha (y_ix_i - 2\lambda w)
$$
else:
$$
w = w + \alpha (-2\lambda w)
$$

In Python language we can write like this:


```python
def __init__(self,lmbd,D):
    self.lmbd = lmbd 
    self.D = D + 1 
    self.w = [0.] * self.D 

def sign(self, x):
    return -1. if x <= 0 else 1.

def hinge_loss(self,target,y):
    return max(0, 1 - target*y)

def train(self,x,y,alpha):
    if y*self.predict(x) < 1:

        for i in xrange(len(x)):
            self.w[i] =  self.w[i] + alpha *( (y*x[i]) + (-2 * (self.lmbd)*self.w[i]) )

    else:
        for i in xrange(len(x)):
            self.w[i] = self.w[i] + alpha * (-2 * (self.lmbd)*self.w[i])
```

    


## Dataset

This article will use the [Skin Segmentation Data](https://archive.ics.uci.edu/ml/datasets/Skin+Segmentation) Set that can be downloaded from the UCI database. This data refers to a classification task in which RGB values of random points are extracted from the face picture of a person, and the task is to determine, according to these values, whether that point corresponds to the skin or another part of the image.

According to the researchers, images of people from various ages, races and genres were collected. A practical application of this task would be to identify images with inappropriate content for minors on the internet.

This dataset is of the dimension 245057 * 4 where first three columns are B,G,R (x1,x2, and x3 features) values and fourth column is a binary classification.

### Evaluation of the result

In a real online environment, one way to evaluate the performance of the model would be to calculate the loss before predicting a new example and averaging in a time window. This method is called progressive validation.

In our case, we are simulating an online environment, and to make the model more effective, I will use a separate test set with 20% of the data.

The files *train.csv* and *test.csv* each contains approximately 20% positive examples, so in addition to loss, I want to evaluate the number of correct answers and errors in each class (real positives and true negatives).

The training set has 196,129 examples, and the test set, 48,928. We will use each example of the training set only once, and then evaluate the performance of the model in the test set.

Since we are not going to use this test set to adjust hyperparameters, it is a legitimate estimate of the model’s performance in new examples. If you are going to use it to validate parameters, you will need another test set.


```python
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
%matplotlib inline

from random import shuffle
```


```python
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/00229/Skin_NonSkin.txt" 
data = pd.read_csv(url, header = None, sep='\t')

np.random.seed(1)

msk = np.random.rand(len(data)) < 0.8
data[msk].to_csv('svm-gradient-descent/train.csv', header=False, index=False)
data[~msk].to_csv('svm-gradient-descent/test.csv', header=False, index=False)
```

With data splited we should start building our model!

## Lets Start implementing Stochastic Gradient Descent 



```python
class SVM():
    """Implementation of SVM with SGD"""
    
    def __init__(self,lmbd,D):
        self.lmbd = lmbd 
        self.D = D + 1 
        self.w = [0.] * self.D 

    def sign(self, x):
        return -1. if x <= 0 else 1.

    def hinge_loss(self,target,y):
        return max(0, 1 - target*y)

    def data(self,test=False):
        if test:
            with open('svm-gradient-descent/test.csv','r') as f:
                samples = f.readlines()

                for t,row in enumerate(samples):

                    row = row.replace('\n','')
                    row = row.split(',')

                    target = -1.

                    if row[3] == '1':
                        target = 1.
                    del row[3]

                    x = [float(c) for c in row] + [1.] #inputs + bias

                    yield t, x,target

        else:

            with open('svm-gradient-descent/train.csv','r') as f:
                samples = f.readlines()
                shuffle(samples)

                for t,row in enumerate(samples):

                    row = row.replace('\n','')
                    row = row.split(',')

                    target = -1.

                    if row[3] == '1':
                        target = 1.
                    del row[3]

                    x = [float(c) for c in row] + [1.] #inputs + bias

                    yield t, x,target
                    
    def train(self,x,y,alpha):
        if y*self.predict(x) < 1:

            for i in xrange(len(x)):
                self.w[i] =  self.w[i] + alpha *( (y*x[i]) + (-2 * (self.lmbd)*self.w[i]) )                

        else:
            for i in xrange(len(x)):
                self.w[i] = self.w[i] + alpha * (-2 * (self.lmbd)*self.w[i])
        
        return self.w
                
    def predict(self,x):
        wTx = 0.
        for i in xrange(len(x)):

            wTx += self.w[i]*x[i]

        return wTx
    
    def fit(self):
        test_count = 0.
        
        tn = 0.
        tp = 0.
        
        total_positive = 0.
        total_negative = 0.

        accuracy = 0.
        loss = 0.
        
        
        last = 0
        for t, x,target in self.data(test=False):
            
            if target == last: 
                continue
            
            alpha = 1./(self.lmbd*(t+1.))
            w = self.train(x,target,alpha)
            last = target
    
        for t,x,target in self.data(test=True):
            
            pred = self.predict(x)
            loss += self.hinge_loss(target,pred)
            
            pred = self.sign(pred)
            
            
            if target == 1:
                total_positive += 1.
            else:
                total_negative += 1.
            
            if pred == target:
                accuracy += 1.
                if pred == 1:
                    tp += 1.
                else:
                    tn += 1.
            
        loss = loss / (total_positive+total_negative)
        acc = accuracy/(total_positive+total_negative)
        
        # print 'Loss', loss, '\nTrue Negatives', tn/total_negative * 100, '%', '\nTrue Positives', tp/total_positive * 100, '%','\nPrecision', accuracy/(total_positive+total_negative) * 100, '%', '\n'
    
        return loss, acc, tp/total_positive,tn/total_negative, w
```


```python
loss_list = []
acc_list = []
tp_list = []
tn_list = []
w_list = []

for i in range(100):
    
    #print '\nSeed',i
    
    np.random.seed(i)
    
    svm = SVM(1,3)

    l,acc,tp,tn,w = svm.fit()

    loss_list.append(l)
    acc_list.append(acc)
    tp_list.append(tp)
    tn_list.append(tn)
    w_list.append(w)

print 'Loss', sum(loss_list)/len(loss_list)
print 'Accuracy', sum(acc_list)/len(acc_list) * 100, '%'
print 'True Positives', sum(tp_list)/len(tp_list) * 100, '%'
print 'True Negatives',sum(tn_list)/len(tn_list) * 100, '%'
```

    Loss 0.336361424342
    Accuracy 93.1521419228 %
    True Positives 99.6179310345 %
    True Negatives 91.4597452164 %


#### Last epoch results:


```python
print 'Loss', loss_list[-1]
print 'Accuracy', acc_list[-1] * 100, '%'
print 'True Positives', tp_list[-1] * 100, '%'
print 'True Negatives', tn_list[-1] * 100, '%'
```

    Loss 0.319685882105
    Accuracy 93.5803629823 %
    True Positives 100.0 %
    True Negatives 91.9000464181 %


**Weight vector**


```python
w_list[-1]
```




    [-0.012143435142372257,
     -0.014424186650153442,
     0.024160846426260787,
     -0.02904598219297061]



#### Code Description

#### Init  

1. SVM model parameters: $\lambda$ as regularization and $D$ as the number os features plus bias

#### Sign  

1. Funtion that assigns according to the side of hyperplan

#### Hinge Loss

1. Function to be minimized

#### Data 

1. Data generator.
2. Iterate over each sample in the data set.

#### Train 

1. Misclassification condition $y_i \langle x_i,w \rangle < 1$
2. Update rule for the weights $w = w + \alpha (y_ix_i - 2\lambda w)$ including the learning rate $\alpha$ and the regularizer $\lambda$.
3. If classified correctly just update the weight vector by the derived regularizer term $w = w + \alpha (-2\lambda w)$.
4. Save the weight vector.

#### Predict 

1. Calculates the scalar product between the weights and the attributes 

#### Fit 

1. Train the SVM and give estimates on the test set
2. Ensuring that the next example seen by the algorithm is different from the previous one to improve unbalanced dataset predictions. 
3. Reporting true positives / negatives. Metrics that are not sensitive to the disproportionate classes. 
4. The learning parameter $\alpha$ is regularized as $\frac{1}{\lambda (t+1)}$, so this parameter will decrease, as the number of epochs $t$ increases. 
 

## Weight Vector


```python
w_list[-1]
```




    [-0.012143435142372257,
     -0.014424186650153442,
     0.024160846426260787,
     -0.02904598219297061]



The weight vector of the SVM including the bias term after 100 epochs is $(-0.012,  -0.0144,  0.024, -0.029)$.
We can extract the following prediction function now:

$$
f(x) = \langle x,(-0.012,-0.0144,0.024)\rangle - 0.029
$$

## Evaluation

Lets classify the samples in our data set by hand now, to check how the model learned:


```python
w_list[-1]
```




    [-0.012143435142372257,
     -0.014424186650153442,
     0.024160846426260787,
     -0.02904598219297061]




```python
with open('svm-gradient-descent/train.csv','r') as f:
    samples = f.readlines()
    shuffle(samples)
samples[0:10]
```




    ['44,45,11,2\n',
     '157,159,129,2\n',
     '47,89,142,1\n',
     '7,5,0,2\n',
     '201,200,162,2\n',
     '180,180,132,2\n',
     '52,52,16,2\n',
     '196,195,161,2\n',
     '199,198,160,2\n',
     '64,67,28,2\n']



First sample $(44, 45, 11)$, supposed to be -1:

$$(-0.012*44)+(-0.0144*45)+(0.0242*11) - 0.029 = sign(-0.9388) = -1$$

Second sample $(157, 159, 129)$, supposed to be -1:

$$(-0.012*157)+(-0.0144*159)+(0.0242*129) - 0.029 = sign(-1.0808) = -1$$

Third sample $(47, 89, 142)$, supposed to be 1:

$$(-0.012*47)+(-0.0144*89)+(0.0242*142) - 0.029 = sign(1.5618) = 1$$


All example samples are classified right.

## Fonts

* An Introduction to Statistical Learning - book
* [Matheus Facure - blog](https://matheusfacure.github.io/2017/02/20/MQO-Gradiente-Descendente/)
* [Mavi - blog](https://maviccprp.github.io/a-support-vector-machine-in-just-a-few-lines-of-python-code/)
* [Sandipanweb](https://sandipanweb.wordpress.com/2018/04/29/implementing-pegasos-primal-estimated-sub-gradient-solver-for-svm-using-it-for-sentiment-classification-and-switching-to-logistic-regression-objective-by-changing-the-loss-function-in-python/)
