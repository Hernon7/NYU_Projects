#%%
import pandas as pd 
from pandas import read_csv
from matplotlib import pyplot
import numpy

url="https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv"
name = names = ['preg', 'plas', 'pres', 'skin', 'test', 'mass', 'pedi', 'age', 'class'] 
data = read_csv(url,names=names)
#%%
#get the last 5 rows of data
peek = data.tail(5)
print(peek)
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
pd.set_option('precision',3)# set the precision(精度)
description = data.describe()
print(description)
#%%
#group by specific attributes
class_counts = data.groupby('class').size()
print(class_counts)
#%%
#get correlations(相关性)
correlations = data.corr(method = 'pearson')
print(correlations)
#%%
#get skew
skew=data.skew()
print(skew)
#skew = 0 normal distribution
#是指非对称分布的偏斜状态。换句话说，就是指统计总体当中的变量值分别落
# 在众数（M0）的左右两边，呈非对称性分布
#%%
data.hist()
pyplot.show()
#%%
data.plot(kind='density', subplots=True, layout=(3,3), sharex=False)
pyplot.show()
data.plot(kind='box', subplots=True, layout=(3,3), sharex=False, sharey=False)
pyplot.show()
#%%
#Get correlations
correlations = data.corr()
# plot correlation matrix
fig = pyplot.figure()
ax = fig.add_subplot(111)
cax = ax.matshow(correlations, vmin=-1, vmax=1)
fig.colorbar(cax)
ticks = numpy.arange(0,9,1)
ax.set_xticks(ticks)
ax.set_yticks(ticks)
ax.set_xticklabels(names)
ax.set_yticklabels(names)
#show plot
pyplot.show()

