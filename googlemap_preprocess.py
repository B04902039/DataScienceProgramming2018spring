# -*- coding: utf-8 -*-
"""
Created on Wed May 23 20:37:37 2018

@author: 羅際禎
"""

import pandas as pd
import googlemaps

df = pd.read_csv('2016_2.csv', encoding='big5', skiprows=1)
cols = ['district', 'type', 'address', 'land_size', 'purpose', 'nan1', 'nan2',
        'date', 'pen', 'level', 'floor_num', 'build_state', 'use', 'material',
        'complete_yr', 'total_size', 'room', 'hall', 'health', 'compartmented',
        'manage', 'furniture', 'PRICE', 'unit_PRICE', 'berth', 'berth_size',
        'berth_price', 'note', 'serial_num', 'nan3']
df.columns = cols
df.drop(['nan1', 'nan2', 'nan3'], axis=1, inplace=True)
address = df.address.values

#APIkey='AIzaSyBq75w0cn9LVNWZikHm45BC4J2crxz2AYM'#used
#APIkey='AIzaSyCFljEt_tl-qDAuLc2jUOAoB400MsugCBc'#used
#APIkey='AIzaSyDL9XUaDnZsre7hrg9SYuuj6SbBYSnqeeU'#used
#APIkey='AIzaSyB0P-ZDAW8ct5rKe3L19sSLPT_O_uOyL-c'#used
#APIkey='AIzaSyAVPm4mZedRucOYqtDJfpJoKpNsdsDK5RI'
#APIkey = 'AIzaSyAFkazBVX5-Zz8Kt54wJOEFlgYGXp2GOyA'#2016Q1
APIkey = 'AIzaSyDerxbVfu-wfiyESSyAnO0v5669OqG2VkQ'#2016Q2
#APIkey = 'AIzaSyDProji7uSvID745G8AJvK3K9Jpu4FH2KI'#2016Q3
#APIkey = 'AIzaSyCQjpnOjuU_BhnDMRuLW7Y3Mcb4yNCpOn8'#2016Q4
#APIkey = 'AIzaSyAe5kCL307hcpcfzK0aOvTZK_uEwU2f3so'#2015Q1
#APIkey = 'AIzaSyAS2AOeKCXTZhi3vAcplmwXUgezu19Q5_g'#2015Q2
#APIkey = 'AIzaSyCz6Ztoo6qDvEFzxfsktR2nDJo6ZhtREKU'#2015Q3
#APIkey = 'AIzaSyCrUKl6e68i47weZND5kCipsgjAxeUSlMk'#2015Q4
gmaps = googlemaps.Client(key=APIkey)
lat = []
lng = []
for i in range(len(address)):
    result = gmaps.geocode(address[i])
    if result:
        lat_tmp = result[0]['geometry']['location']['lat']
        lng_tmp = result[0]['geometry']['location']['lng']
    else:
        lat_tmp = 0 
        lng_tmp = 0
    print(i, address[i], lat_tmp, lng_tmp)
    lat.append(lat_tmp)
    lng.append(lng_tmp)
lat = pd.DataFrame(lat)
lat.columns = ['lat']
lng = pd.DataFrame(lng)
lng.columns = ['lng']

df = pd.concat([df, lat, lng], axis=1)
df.to_csv('2016Q2.csv', index=False)