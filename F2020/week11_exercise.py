#!/usr/bin/env python
# coding: utf-8

# # week11 exercise

# In[1]:


import numpy as np
import matplotlib.pyplot as plt


# ### set up parameters

# In[2]:


a  = -np.log(2)/5700; # per year
b  = 0;   # no source for C-14 
X0 = 100; # initial condition
dt = 1000;   # time step
N  = 50; # number of time steps
t  = np.arange(0,N*dt,dt) # set up time axis


# ### analytic solution

# In[3]:


# steady solution
Xbar = -b/a
# analytic solution
X0p = X0-Xbar;
Xa = Xbar + X0p*np.exp(a*t);


# In[4]:


## plot the analytic solution
plt.plot(t/1000,Xa);
plt.xlabel('1000s of years');
plt.ylabel('C-14');
plt.legend(['Analytic'])
plt.show()


# ### Numerical solution

# In[5]:


# we solve with Euler forward method
X=np.zeros((N,1))
X[0]=X0; # set initial condition
for n in range(0,N-1): # time stepping loop
    dXdt = a*X[n]
    X[n+1]=X[n]+dt*dXdt


# In[6]:


# plot in red
plt.plot(t/1000,Xa,'b-');
plt.plot(t/1000,X,'ro-')
plt.legend(['Analytic', 'Euler Forward'])
plt.xlabel('1000s of years');
plt.ylabel('C-14');
plt.show()


# In[7]:


# we solve with Euler backward method
Xb=np.zeros((N,1))
Xb[0]=X0; # set initial condition
for n in range(0,N-1): # time stepping loop
    Xb[n+1]=Xb[n]/(1-dt*a)


# In[8]:


# plot in cyan
plt.plot(t/1000,Xa,'b-')
plt.plot(t/1000,X,'ro-')
plt.plot(t/1000,Xb,'c.-')
plt.legend(['Analytic', 'Euler Forward', 'Eular Backward'])
plt.xlabel('1000s of years');
plt.ylabel('C-14');
plt.show()


# In[ ]:




