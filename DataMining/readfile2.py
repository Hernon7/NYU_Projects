import pandas as pd 
from sklearn.preprocessing import MinMaxScaler
import numpy as np
from matplotlib import pyplot
from pandas import read_csv
filename1='2.csv'
name = names = ['preg', 'plas', 'pres', 'skin', 'test', 'mass', 'pedi', 'age', 'class'] 
data = read_csv(filename1,names=names)
print(data)