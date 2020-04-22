# Project 4: Algorithm implementation and evaluation: Collaborative Filtering

### [Project Description](doc/project4_desc.md)

Term: Spring 2020

+ Team 1
+ Project title: Algorithm implementation and evaluation: Collaborative Filtering
+ Team members
	+ Chen, Shenghan
	+ Chen, Shuyi
	+ Guo, Junyan 
	+ Heagy, David 
	+ Xie, Wenjie 
+ Project summary: In this project, we are going to ultilize matrix factorization methods for recommender system on the Netflix movies and ratings data, aiming to match consumers with most appropriate products. Matrix factorization methods represent both items and users with vectors of factors inferred from item rating patterns. High correspondence between item and user factors leads to a recommendation. 

Matrix factorization usually possess three parts. Our group has been assigned with the following algorithm, regularization and postprocessing:

- factorization algorithm: Stochastic Gradient Descent

- regularization: Penalty of Magnitudes + Bias and Interecepts vs Penalty of Magnitudes + Temporal Dynamics

- postpocessing: Singular value decomposition with K-nearest neighbor

We are going to compare the regularization methods given stochastic Gradien descent factorization algorithm and KNN post processing. Finally, we will combine the prediction through the linear regression process.

	
**Contribution statement**: [default] 
All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
