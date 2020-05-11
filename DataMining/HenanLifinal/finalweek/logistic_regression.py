#%%
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression 

filename = 'logistic_data.csv'  
dataframe = pd.read_csv(filename) 
print(dataframe)
array = dataframe.values 
X = array[:,0:2] 
Y = array[:,2] 

#create the logistic Regression
model = LogisticRegression(solver="lbfgs") 
result = model.fit(X, Y)
result = model.score(X, Y)
print(f'Accuracy: {result*100.0}') 

#making a prediction
x_predict = np.array([[1.38807,1.85022]])
y_predict = model.predict(x_predict)
print (y_predict)

#%%
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression 
from sklearn.externals.joblib import dump

filename = 'logistic_data.csv'  
dataframe = pd.read_csv(filename) 
array = dataframe.values 
X = array[:,0:2] 
Y = array[:,2] 

#create the logistic Regression
model = LogisticRegression(solver="lbfgs") 
result = model.fit(X, Y)
result = model.score(X, Y) 

# save the model to disk 
filename = 'final_model.sav'
dump(model, filename)

#%%
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression 
from sklearn.externals.joblib import load

# load the model from disk 
filename = 'final_model.sav'
loaded_model = load(filename) 

#Predict using saved model
x_predict = np.array([[1.38807,1.85022]])
y_predict = loaded_model.predict(x_predict)
print (y_predict)
