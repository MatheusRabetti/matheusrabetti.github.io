---
layout: page
title: About Me
tags: [about]
comments: false
permalink: /about/
---

I am a Data Scientist at [Globo.com](http://www.globo.com/) graduated in Statistics from the [University of Brasilia, (UnB)](http://www.est.unb.br/). For a year and a half I did a master's degree in quantitative finance with a focus on risk default. During this period I discovered how to learn, how I learn. Being curious, challenging problems, chewing technical and academic books, beta testing, following those off the curve and experimenting with new technologies. Classic academic conduits aren't providing Data Scientists -- this talent gap will be closed differently.

> **Academic credentials are important but not necessary for high-quality data science.** The core aptitudes – curiosity, intellectual agility, statistical fluency, research stamina, scientific rigor, skeptical nature – that distinguish the best data scientists are widely distributed throughout the population.

-- James Kobielus, [Closing the Talent Gap](http://bit.ly/closingthetalentgap) 17 Jan 2013

<br>
Since this discovery I have dedicated myself on this path always avoiding the “comfort zone”. Being good at something doesn’t mean that you can be satisfied with it. There’s always more that you can achieve, that you can improve!

<style>
/* python -m SimpleHTTPServer 8888 & */

.bullet { font: 8px Helvetica; }
.bullet .marker { stroke: #0F2535; stroke-width: 2px; }
.bullet .tick line { stroke: #666; stroke-width: .5px; }
.bullet .range.s0 { fill: #eee; }
.bullet .range.s1 { fill: #FFFFFF; }
.bullet .range.s2 { fill: #F9F9F9; }
.bullet .measure.s0 { fill: #FCB07E; }
.bullet .measure.s1 { fill: #E8992C; }
.bullet .title { font: 12px Helvetica; font-weight: bold; }
.bullet .subtitle { fill: #999; }

</style>
<script src="//d3js.org/d3.v3.min.js"></script>
<script src="../assets/bullet.js"></script>
<script>

var margin = {top: 5, right: 40, bottom: 20, left: 150},
    width = 520 - margin.left - margin.right,
    height = 40 - margin.top - margin.bottom;

var chart = d3.bullet()
    .width(width)
    .height(height);

d3.json("../assets/explore.json", function(error, data) {
  if (error) throw error;

  var svg = d3.select("div#explore").selectAll("svg")
      .data(data)
    .enter().append("svg")
      .attr("class", "bullet")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      .call(chart);

  var title = svg.append("g")
      .style("text-anchor", "end")
      .attr("transform", "translate(-6," + height / 2 + ")");

  title.append("text")
      .attr("class", "title")
      .text(function(d) { return d.title; });

  title.append("text")
      .attr("class", "subtitle")
      .attr("dy", "1em")
      .text(function(d) { return d.subtitle; });
});


d3.json("../assets/interests.json", function(error, data) {
  if (error) throw error;

  var svg = d3.select("div#interests").selectAll("svg")
      .data(data)
    .enter().append("svg")
      .attr("class", "bullet")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      .call(chart);

  var title = svg.append("g")
      .style("text-anchor", "end")
      .attr("transform", "translate(-6," + height / 2 + ")");

  title.append("text")
      .attr("class", "title")
      .text(function(d) { return d.title; });

  title.append("text")
      .attr("class", "subtitle")
      .attr("dy", "1em")
      .text(function(d) { return d.subtitle; });
});


</script>

#### Skills
<div id="explore"></div>

#### Interests
<div id="interests"></div>

<br>
Courses
============

* [MITx: 15.071x The Analytics Edge](https://www.edx.org/course/analytics-edge-mitx-15-071x-2): MIT’s The Analytics Edge is an edX course focused on using statistical tools to gain insight about data and make predictions. It has around 75 datasets and starts from linear regression upto clustering and some classification techniques like Random Forest and CART models in between.

* [Data Science Specialization](https://www.coursera.org/specializations/jhu-data-science): This Specialization covers the concepts and tools you'll need throughout the entire data science pipeline, from asking the right kinds of questions to making inferences and publishing results.

* [Master Statistics with R](https://www.coursera.org/specializations/statistics): This Specialization showed how to analyze and visualize data in R and created reproducible data analysis reports, demonstrate a conceptual understanding of the unified nature of statistical inference, perform frequentist and Bayesian statistical inference and modeling to understand natural phenomena and make data-based decisions.


Publications
============

1. Rabetti, M.S.; Nadalin, V.G.; Oliveira, C.A.P.; Furtado, B.A.; Cavalcanti, C.B. (2016) <a href="http://www.ipea.gov.br/portal/index.php?option=com_content&view=article&id=28469&Itemid=406"> Population and Employment Dynamics in the Urban Centers of the Brazilian Metropolis </a>. 

2. Rabetti, M.S.; Sambuichi, R.H.R.; Galindo, E.P.; Pereira, R.M.; Cconstantino, M. (2016) <a href="http://www.ipea.gov.br/portal/index.php?option=com_content&view=article&id=27858"> Production Diversity in Family Agriculture Establishments in Brazil: an econometric analysis based on the registration of the Declaration of Aptitude to Pronaf (DAP) </a>.

3. Rabetti, M.S. and Carvalho, C.H.R. (2015) <a href="http://www.ipea.gov.br/portal/images/stories/PDFs/relatoriopesquisa/150922_relatorio_acidentes_transito.pdf"> Traffic accidents on Brazilian federal highways </a>. 


Links
=====

* I worked on the development, calculation and construction along a BI team of a interactive plataform to analyse the brazilian labour market, [Painel de Monitoramento do Mercado de Trabalho](http://mercadodetrabalho.mte.gov.br/).

* I've done all analysis procedures on the IVS project, a plataform developed in partnership betweend United Nations Development Programme and Institute for Applied Economic Research, [IVS](http://ivs.ipea.gov.br/ivs/en/mapa/).

* Some results of the third publication listed above - Mapping the Economic Centers of Brazil, [RPubs Portfolio](https://rpubs.com/msrabetti/rais_leaflet)


About This Site
=========

This site is powered by [Jekyll](http://jekyllrb.com/) using the [Minimal Mistakes](http://mademistakes.com/minimal-mistakes/) theme. All blog posts are released under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

All blog posts are compiled with [knitr](http://yihui.name/knitr/) [R markdown](http://rmarkdown.rstudio.com/). You can find the reproducible sources of each blog post [here](https://github.com/matheusrabetti/matheusrabetti.github.io/tree/master/_R).

