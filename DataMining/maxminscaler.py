#%%
import pandas as pd 
from sklearn.preprocessing import MinMaxScaler
import numpy as np
from matplotlib import pyplot
from pandas import read_csv
from numpy import set_printoptions
from sklearn.preprocessing import MinMaxScaler
#%%
filename='1.csv'
data = read_csv(filename)
#%%
array = data.values
X = array[:,0:8]
Y = array[:,8]
#applied range of 0 to 1
scaler = MinMaxScaler(feature_range=(0, 1))
rescaledX = scaler.fit_transform(X)

set_printoptions(precision=3)
print(rescaledX[0:5,:])
#%%
# Chi-squared
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import chi2
# feature extraction
test = SelectKBest(score_func=chi2, k=4)
fit = test.fit(X, Y)
# summarize scores
set_printoptions(precision=3)
print(fit.scores_)
features = fit.transform(X)
# Print results
print(features[0:5,:])
#%%
# Chi-squared
from sklearn.feature_selection import RFE
from sklearn.linear_model import LogisticRegression

model = LogisticRegression(solver='liblinear’) #several different options
rfe = RFE(model,3) #change 3 to different number and observe results
fit = rfe.fit(X, Y)
print(f'Num Features: {fit.n_features_}')
print(f'Selected Features: {fit.support_}')
print(f'Feature Ranking: {fit.ranking_}') 

#%%
from sklearn.decomposition import PCA
# feature extraction
pca = PCA(n_components=3)
fit = pca.fit(X)
# summarize components
print(f'Explained Variance: {fit.explained_variance_ratio_}')
print(fit.components_)
#%%
from pandas import read_csv
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

#Split the dataset
X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=.33, random_state=7)
model = LogisticRegression()
model.fit(X_train, Y_train)
result = model.score(X_test, Y_test)
print(f'Accuracy: {result*100.0}') 
#%%
from pandas import read_csv
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score 
from sklearn.linear_model import LogisticRegression

#Split the dataset 
kfold = KFold(n_splits=10, random_state=7)
model = LogisticRegression()
results = cross_val_score(model, X, Y, cv=kfold)
print(f'Accuracy: {results.mean()*100.0} ({results.std()*100.0})')

#%%
# Leave One Out Cross Validation
from pandas import read_csv
from sklearn.model_selection import LeaveOneOut
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression
import warnings
warnings.filterwarnings("ignore", category=FutureWarning)

X = array[:,0:8]
Y = array[:,8]


#Split the dataset 
loocv = LeaveOneOut()
model = LogisticRegression()
results = cross_val_score(model, X, Y, cv=loocv)
print(f'Accuracy: {results.mean()*100.0} ({results.std()*100.0})')  

#%%
from pandas import read_csv
from sklearn.model_selection import ShuffleSplit
from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression
import warnings
warnings.filterwarnings("ignore", category=FutureWarning)

kfold = ShuffleSplit(n_splits=10, test_size=.33, random_state=7)
model = LogisticRegression()
results = cross_val_score(model, X, Y, cv=kfold)
print(f'Accuracy: {results.mean()*100.0} ({results.std()*100.0})') 
