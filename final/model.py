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
