#!/usr/bin/env python
# coding: utf-8

# # generate several plots of historical climate data
# ## First import libraries

# In[1]:


import matplotlib.pyplot as plt
import numpy as np


# ## read in the data
# Use genformtxt command from numpy

# In[2]:


my_data = np.genfromtxt('atlanta_temperature.tsv', delimiter='\t')


# ## First figure is the time series of annual mean temperature of Atlanta
# Use plot command from matplotlib

# In[3]:


X=my_data[:,0]
Y=np.mean(my_data[:,1:13],1)
plt.plot(X,Y)
plt.ylabel('ATL annual temp, deg F')
plt.xlabel('Time');


# ## Now generate a histogram of the annual mean temperature
# Use arange to make bins and use hist command from matplotlib

# In[4]:


N=len(Y)
bins=np.arange(58,66,0.5)
plt.hist(Y,bins)
plt.xlabel('temperature, deg F')
plt.ylabel('number of occurrence');


# ## Now calculate Gaussian and overlay
# Use mean, std, sqrt and exp commands from numpy

# In[5]:


mu=np.mean(Y)
std=np.std(Y)
X=np.arange(57.0,66.0,0.1)
f=0.5*N/np.sqrt(2*np.pi)/std*np.exp(-0.5*((X-mu)/std)**2)
plt.hist(Y,bins)
plt.plot(X,f);
plt.xlabel('temperature, deg F')
plt.ylabel('number of occurrence');


# ## Include boxcar diagram for each month of the year
# Use boxplot command from matplotlib

# In[6]:


plt.boxplot(my_data[:,1:13]);
plt.xlabel('month')
plt.ylabel('temperature, deg F');

