Stanford Machine Learning Online Class at Coursera (Fall 2014)

Exercise 8.

Recommender Systems to predict movie ratings to the user

Dataset 'ex8_movies.mat' contains movie ratings (MovieLens 100k Dataset -
GroupLens Research) on a scale from 1 to 5, 943 users and 1682 movies.
The goal is to recommend the movies with the highest predicted ratings that the
user has not rated yet.

First, I implement the function cofiCostFunc.m to compute the regularized
collaborative filtering objective function and regularized gradient. Then,
I use minimizer fmincg.m to learn the parameters.

Run ex8_cofi.m script to train the collaborative filtering model and make
recommendations.
