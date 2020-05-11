#%%
# Feature Extraction with Univariate Statistical Tests (Chi-squared for classification)
from pandas import read_csv
from numpy import set_printoptions
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import chi2
#%%
# load data
filename = 'export.csv'
data = read_csv(filename)
print(data)
#%%
#assign the shape function returns the dimention of the array
shape = data.shape
print(shape)
#%%
array = data.values
X = array[:,1:6]
Y = array[:,6]
# feature extraction
test = SelectKBest(score_func=chi2, k=1)
fit = test.fit(X, Y)
# summarize scores
set_printoptions(precision=3)
print(fit.scores_)
features = fit.transform(X)
# summarize selected features
print(features[0:5,:])

