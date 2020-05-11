#%%
# Import libraries 
import pandas as pd 
from pandas import read_csv
from matplotlib import pyplot
import numpy
from pandas.plotting import scatter_matrix
#read file
filename='irisfinal.csv'
data = read_csv(filename)
print(data)

#%%
#assign the shape function returns the dimention of the array
shape = data.shape
print(shape)

#%%
#It returns the data type of the dataset
type = data.dtypes
print(type)

#%%
#use pandas.describe() function to get insights on each attribute
pd.set_option('display.width',100)# set the width of the output 
pd.set_option('precision',3)# set the precision
description = data.describe()
print(description)
#It show the min,max and mean value of each attritute in the dataset
#%%
#get skew
skew=data.skew()
print(skew)
#Skewness is asymmetry in a statistical distribution, in which the curve appears distorted or skewed either to the left or to the right. Skewness can be quantified to define the extent to which a distribution differs from a normal distribution.
#%%
#get the histograms for each variable
data.hist()
pyplot.show()
#The gragh shows the length and width tend to change together.
#%%
#get the density plots
# The desity plot can show the data distribution.
#In length and width have similar distributin for sepal and petal. 
data.plot(kind='density', subplots=True, layout=(3,3), sharex=False)
pyplot.show()

#%%
#get the density plots
#The box chart shows dispersion degree of the data. The sepal data tend to concentrete to the average and 
#The petal data has larger fluctuation range
data.plot(kind='box', subplots=True, layout=(3,3), sharex=False, sharey=False)
pyplot.show()


#%%
#build scatter_matrix
#A scatter matrix is a pair-wise scatter plot of several variables presented in a matrix format. It can be used to determine whether the variables are correlated and whether the correlation is positive or negative.
#It shows the different attributes have small correlation
scatter_matrix(data)
#show chart
pyplot.show()

#%%
#Get correlations
correlations = data.corr()
# plot correlation matrix
#It also shows the different attributes have small correlation.
names = ['sepal_length','sepal_width','petal_length','petal_width','species']
fig = pyplot.figure()
ax = fig.add_subplot(111)
cax = ax.matshow(correlations, vmin=-1, vmax=1)
fig.colorbar(cax)
ticks = numpy.arange(0,4,1.1)
ax.set_xticks(ticks)
ax.set_yticks(ticks)
ax.set_xticklabels(names)
ax.set_yticklabels(names)
#show plot
pyplot.show()