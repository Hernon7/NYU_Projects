import pandas as pd 
from sklearn.preprocessing import MinMaxScaler
import numpy as np
from matplotlib import pyplot
from pandas import read_csv
filename='1.csv'
data = read_csv(filename)

data = np.array([[1], [2],[3],[4],[5]])

min_max_scaler = MinMaxScaler(feature_range=(0, 1))
rescaled_min_max_scaler = min_max_scaler.fit_transform(data)
print(rescaled_min_max_scaler)
from sklearn.preprocessing import MinMaxScaler
import numpy as np
#single feature
data = np.array([[1], [2],[3],[4],[5]])

min_max_scaler = MinMaxScaler(feature_range=(0, 1))
rescaled_min_max_scaler = min_max_scaler.fit_transform(data)
print(rescaled_min_max_scaler)
