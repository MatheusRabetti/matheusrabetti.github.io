---
layout: post
title: Building a Data Science Team
description: Efficieny and accontability tradeoff
categories:
  - Business
tags: [Business]
---


> “What is the relationship like between your team and the data scientists?” 

This is, without a doubt, the question I had most asked myself. Why is that? If you read the recruiting propaganda of data science and look at the others roles on your departament team, you might see functions overlapping. Also, everyone wants to be the thinker, the model builder.

My first time as a just arrived data scientist in a team full of experienced and respected engineers in the company left me extremely uncomfortable in the early months. The truth is that they were really talented and capable of doing pretty awesome data analysis. One of them had built most of the recommendation systems algorithms. While I marveled also got scared keeping asking myself: "Shouldn't they be building the infrastructure to the data scientists do the analysis?". At first I felt the need to have a clear role on the production process.

While building my space and setting aside the fear I realized and would like to propose to you what I believe is a better way to structure a data science department. A way that allows for autonomy in roles, true ownership all the way into production, and accountability for output. A way that is well suited for a company with a quickly evolving business (and data) model.

# Enable Everyone to be Best in the World

Let’s forget the traditional roles, and instead think about the intrinsic motivations that get folks excited to come to work in the morning.

Regardless of role, a fundamental differentiator between adequate and great people lies in their desire and talent for being creative. Great people are able to identify and creatively solve problems that would absolutely baffle the mediocre. They excel in and crave for an environment of autonomy, ownership, and focus. 

<br>
<br>
![center](/assets/posts/data-science-team/account.jpg)
<br>

### Data Scientists:

Data scientists love working on problems that are vertically aligned with the business and make a big impact on the success of projects/organization through their efforts. They set out to optimize a certain thing or process or create something from scratch. These are point-oriented problems and their solutions tend to be as well. They usually involve a heavy mix of business logic, reimagining of how things are done, and a healthy dose of creativity. Thus, they require a deep understanding of how specific portions of the business operate and a high degree of partnership with business verticals.

### Engineers:

Engineers excel in a world of abstraction, generalization, and finding efficient solutions in the places where they are needed. These problems are usually horizontally oriented in nature. They can be most impactful when applied broadly. They require a good overall understanding of how the business operates, but the abstracted nature of solutions mean they are light on business logic and do not require a heavy partnership with or deep understanding of verticals within the business.

# Thinker-Doers

A common fear of engineers in the data space is that, regardless of the job description or recruiting hype you produce, you are secretly searching for an ETL engineer. In case you did not realize it, nobody enjoys writing and maintaining data pipelines or ETL. It’s the industry’s ultimate hot potato. It really shouldn’t come as a surprise then that ETL engineering roles are the archetypal breeding ground of mediocrity.

Engineers should not write ETL. For the love of everything sacred and holy in the profession, this should not be a dedicated or specialized role. There is nothing more soul sucking than writing, maintaining, modifying, and supporting ETL to produce data that you yourself never get to use or consume.

Instead, give people end-to-end ownership of the work they produce (autonomy). In the case of data scientists, that means ownership of the ETL. It also means ownership of the analysis of the data and the outcome of the data science. The best-case outcome of many efforts of data scientists is an artifact meant for a machine consumer, not a human one. Rather than a report, dashboard, or PowerPoint presentation, it is some sort of algorithm or API that is integrated into the engineering stack – something that fundamentally changes the operation of the business.

# Don't Fear Inefficiency

On this model, everyone have a much more challenging and demanding role than they do in the standard model. We are not optimizing the organization for efficiency, we are optimizing for autonomy. What is offered is clear ownership of ideas and accountability for their delivery.

These are roles that are very attractive to folks who embrace an entrepreneurial mindset. It allows for quick movement, eliminates the need for building unnecessary consensus, and opens the door to disruptive innovation. But it does come at the cost of specialization, and thus efficiency.

A consequence of empowering data scientists to take on such a breadth of the stack is that they will be unlikely to produce code and solutions that are as technically efficient as an engineer’s. We are sacrificing technical efficiency for velocity and autonomy. It is important to recognize this as a deliberate trade off.

There is, however, a set of less obvious efficiencies that are gained with end-to-end ownership. The data scientists are experts in the domain of the implementations they are producing. Thus, they are well equipped to make trade offs between technical and support costs vs. requirements. For example, they can decide to sample data in certain places, use approximate methods where they make sense, and make decisions to nix or punt features that may produce only very marginal business impacts but come with extremely high development or support costs.