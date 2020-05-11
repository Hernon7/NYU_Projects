#%%
from sklearn import linear_model
import numpy as np
#get our data
x = np.array([1,2,3,4,5]).reshape(-1,1) #reshape() is required if ONE feature
y = [1,3,2,3,5]

#create a linear regression model
lm = linear_model.LinearRegression()#class in madule
model = lm.fit(x,y)

#print the predication
predictions = model.predict(x)
print(predictions)
#[1.2,2.,2.8,3.6,4.4]

#make a prediction (x = 10)
x_new =np.array([10]).reshape(-1,1)
predictions_new = model.predict(x_new)
print(predictions_new)
#[8.4]
