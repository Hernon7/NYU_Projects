#%%
# import module/libary
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings("ignore")

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
#%%
# from pandas import DataFrame,Series

# load csv file
filename = "d.csv"
data = pd.read_csv(filename)
#%%
new_data = data.iloc[:, 1:]
print('head:', new_data.head(), '\nShape:', new_data.shape)
#%%
# describe
print(new_data.describe())
#%%
# check missing value
print(new_data[new_data.isnull() == True].count())

new_data.boxplot()
plt.savefig("boxplot.jpg")
# plt.show()
#%%
# r(correlation coefficient) = covariance(x,y) / (standard deviation(x)*standard deviation(y)) == cov（x,y）/σx*σy
# correlation coefficient 0~0.3 weak correlation 0.3~0.6 medium 0.6~1 strong correlation
print(new_data.corr())
#%%
# kind='reg' regression
# seaborn add BFSL(best fitting straight line) and confidence belt(95%)
sns.pairplot(new_data,
             x_vars=['WORK_BALANCE_STARS', 'CULTURE_VALUES_STARS',
                     'CAREER_OPPORTUNITIES_STARS', 'COMP_BENEFIT_STARS', 'SENIOR_MANAGEMENT_STARS'],
             y_vars='OVERALL_RATINGS', 
             kind='reg')
plt.savefig("pairplot.jpg")
plt.show()

X_train, X_test, Y_train, Y_test = train_test_split(new_data.iloc[:, :5], new_data.OVERALL_RATINGS)

print("original data frature:", new_data.iloc[:, :5].shape,
      ",train data frature:", X_train.shape,
      ",test data frature:", X_test.shape)

print("original data label:", new_data.OVERALL_RATINGS.shape,
      ",train data label:", Y_train.shape,
      ",test data label", Y_test.shape)

model = LinearRegression()

model.fit(X_train, Y_train)

# intercept
a = model.intercept_

# regression coefficient
b = model.coef_

print("BFSL:\nintercept:", a, "\nregression coefficient:", b)
