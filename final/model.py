# -*- coding: utf-8 -*-
"""
Created on Thu May 31 10:49:54 2018

@author: 羅際禎
"""

import numpy as np
import pandas as pd
from sklearn import linear_model, metrics, model_selection, svm, preprocessing, ensemble, tree

df = pd.read_csv('raw_data.csv', encoding='big5')
df.drop(['section', 'address', 'date', 'built_date'], inplace=True, axis=1)
df.dropna(inplace=True)

x = df.drop('unit_PRICE', axis=1).values
y = df.unit_PRICE.values

# categorize data
le = preprocessing.LabelEncoder()
for i in [14, 15, 16]:
    x[:, i] = le.fit_transform(x[:, i])
    
# models
RF = ensemble.RandomForestRegressor(random_state=9487)
result_RF = model_selection.cross_validate(RF, x, y, cv=5, n_jobs=-1, scoring='neg_mean_squared_error', return_train_score=True)
print('5-fold validation acc:', result_RF['test_score'].mean())
result_RF