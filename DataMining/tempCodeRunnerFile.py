import pandas as pd 
from sklearn.preprocessing import MinMaxScaler
import numpy as np
from matplotlib import pyplot
from pandas import read_csv
from numpy import set_printoptions
from sklearn.preprocessing import MinMaxScaler
filename='1.csv'
data = read_csv(filename)
array = data.values
X = array[:,0:8]
Y = array[:,8]
#applied range of 0 to 1
scaler = MinMaxScaler(feature_range=(0, 1))
rescaledX = scaler.fit_transform(X)

set_printoptions(precision=3)
print(rescaledX[0:5,:])
