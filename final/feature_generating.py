# -*- coding: utf-8 -*-
"""
Created on Thu May 31 08:39:28 2018

@author: 羅際禎
"""

import numpy as np
import pandas as pd
import scipy

def lat2y(pts):
    center = 25.048734
    y_ratio = 110768.8  # latitude
    tmp = pts - center
    tmp *= y_ratio
    return tmp

def lon2x(pts):
    center = 121.514231
    x_ratio = 100912.0  # longitude
    tmp = pts - center
    tmp *= x_ratio
    return tmp

def find_closest_dist(data, pts):
    KD = scipy.spatial.KDTree(pts)
    return KD.query(data)[0]    # the nearest distance

df = pd.read_csv('real_estate.csv')
lat = df.lat.values
lng = df.lng.values
data = np.zeros((len(lat), 2))
data[:, 1] = lat2y(lat)
data[:, 0] = lon2x(lng)

tmp = pd.read_csv('bus_station_data.csv', sep=' ')
bus_data = np.zeros((len(tmp), 2))
bus_data[:, 1] = lat2y(tmp.latitude.values)
bus_data[:, 0] = lon2x(tmp.longitude.values)
bus_dist = find_closest_dist(data, bus_data)
print("bus station distance DONE")

tmp = pd.read_csv('MRT_station_data.csv', sep=' ')
mrt_data = np.zeros((len(tmp), 2))
mrt_data[:, 1] = lat2y(tmp.lng.values)  # note the data notation is wrong
mrt_data[:, 0] = lon2x(tmp.lat.values)
mrt_dist = find_closest_dist(data, mrt_data)
print("MRT station distance DONE")

tmp = pd.read_csv('park.final.csv', sep=' ')
park_data = np.zeros((len(tmp), 2))
park_data[:, 1] = lat2y(tmp.Latitude.values)
park_data[:, 0] = lon2x(tmp.Longitude.values)
park_dist = find_closest_dist(data, park_data)
print("park distance DONE")

tmp = pd.read_csv('store_all.csv', sep=' ')
store_data = np.zeros((len(tmp), 2))
store_data[:, 1] = lat2y(tmp.lat.values)
store_data[:, 0] = lon2x(tmp.lng.values)
store_dist = find_closest_dist(data, store_data)
print("store distance DONE")

distances = np.column_stack((bus_dist, mrt_dist, park_dist, store_dist))
new_df = pd.DataFrame(distances)
new_df.columns = ['bus_dist', 'MRT_dist', 'park_dist', 'store_dist']
df = pd.concat([df, new_df], axis=1)
df.to_csv('raw_data.csv', index=False)
