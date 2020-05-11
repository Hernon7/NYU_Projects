#%%
import pandas as pd  
import numpy as np  
import matplotlib.pyplot as plt  
from sklearn.model_selection import train_test_split  
from sklearn.tree import DecisionTreeClassifier  
from sklearn.metrics import classification_report, confusion_matrix 

#import dataset
dataset = pd.read_csv("bill_authentication.csv") 

#get to know your data
dataset.shape  
dataset.head()  

#prepare data
X = dataset.drop('Class', axis=1)  
y = dataset['Class'] 
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20)  

#Fit the model
classifier = DecisionTreeClassifier()  
classifier.fit(X_train, y_train)  

#use the test data to test model
y_pred = classifier.predict(X_test)  

#evaluate
print(confusion_matrix(y_test, y_pred))  
print(classification_report(y_test, y_pred))


#%%
from sklearn import datasets
from sklearn import metrics
from sklearn.naive_bayes import GaussianNB

#load dataset
dataset = datasets.load_iris()

#fit model
model = GaussianNB()
model.fit(dataset.data, dataset.target)
expected = dataset.target

#predict
predicted = model.predict(dataset.data)

#get accuracy
print(metrics.classification_report(expected, predicted))
print(metrics.confusion_matrix(expected, predicted))

#%%

#%%
# Import LabelEncoder
from sklearn import preprocessing
#Import Gaussian Naive Bayes model
from sklearn.naive_bayes import GaussianNB
import numpy as np

# Assigning features and label variables
weather=['Sunny','Sunny','Overcast','Rainy','Rainy','Rainy','Overcast','Sunny','Sunny',
'Rainy','Sunny','Overcast','Overcast','Rainy']
temp=['Hot','Hot','Hot','Mild','Cool','Cool','Cool','Mild','Cool','Mild','Mild','Mild','Hot','Mild']
play=['No','No','Yes','Yes','Yes','No','Yes','No','Yes','Yes','Yes','Yes','Yes','No']

#creating labelEncoder
le = preprocessing.LabelEncoder()

# Converting string labels into numbers.
weather_encoded=le.fit_transform(weather)
#print(weather_encoded)

# Converting string labels into numbers
temp_encoded=le.fit_transform(temp)
label=le.fit_transform(play)
label = np.array(label)
#print ("Temp:",temp_encoded)

#Combining weather and temp into single listof tuples
#print(weather_encoded)
#print(temp_encoded)
features = list(zip(weather_encoded,temp_encoded))

#Create a Gaussian Classifier
model = GaussianNB()

# Train the model using the training sets
model.fit(features,label)
#Predict Output
predicted= model.predict([[0,2]]) # 0:Overcast, 2:Mild
print ("Predicted Value:", predicted)
