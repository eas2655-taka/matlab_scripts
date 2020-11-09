#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# Week13 exercise


# In[ ]:


import numpy as np
import matplotlib.pyplot as plt


# In[ ]:


# one dimensional advection equation


# In[ ]:


# setting up model parameters
dt=0.1
L=5
Nt=500
Nx=20
U=0.3
x=np.linspace(-L,L,Nx)
dx=2*L/Nx
C=U*dt/dx
print('Courant number is '+str(C))


# In[ ]:


# setting up grid and initial condition
C=np.zeros((Nx,Nt))
C[:,0]=np.exp(-0.5*(x)**2)


# In[ ]:


# time stepping loop
for n in range(0,Nt-1):
    
    # take care of the boundary points
    C[0,n+1]=C[0,n]-U*dt/(2*dx)*(C[1,n]-C[Nx-1,n])
    C[Nx-1,n+1]=C[Nx-1,n]-U*dt/(2*dx)*(C[0,n]-C[Nx-2,n])
    
    for m in range(1,Nx-1):
        C[m,n+1]=C[m,n]-U*dt/(2*dx)*(C[m+1,n]-C[m-1,n])


# In[ ]:


# plot the result 
for n in range(0,round(Nt/20)):
    plt.plot(x,C[:,n*20],'.k-')
    plt.title('time='+str(round(n*dt,3)))
    plt.show()


# In[ ]:




