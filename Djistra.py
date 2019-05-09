# -*- coding: utf-8 -*-
"""
Created on Fri Nov 23 09:08:09 2018

@author: hyf
"""
#Djistra
f = open('C:\\Users\\hyf\\Desktop\\机器学习数据集\\美国500个机场网络数据.txt')        #打开数据文件文件
lines = f.readlines()      #把全部数据文件读到一个列表lines中

import numpy as np
data=[]#读入数据
for i in range(np.size(lines)):
    data_ind=lines[i].split()
    data.append(data_ind)
  
data=np.array(data,dtype=int)
number=max(data[:,0])#共有多少个结点
#生成距离矩阵
dist_matrix=np.zeros((number+1,number+1))
for i in range(np.size(data,0)):
    dist_matrix[data[i,0]][data[i,1]]=data[i,2]

up_bound=sum(data[:,2])
def shortest_value(dist_matrix,up_bound,nodeid):
    last_dist=[[nodeid,0]]
    
    number=np.size(dist_matrix,0)-1
    path=nodeid*np.ones(number+1)
    path=list(map(int,path))
    path[0]=0
    #path[nodeid]=nodeid
    initial_dist=np.zeros((number,2))#初始化距离
    initial_dist[:,0]=np.arange(1,501)
    initial_dist[:,1]=up_bound
    initial_dist[initial_dist[:,0]==nodeid,1]=0
    index=np.nonzero(dist_matrix[nodeid,:])[0]
    initial_dist=np.delete(initial_dist,np.nonzero(initial_dist[:,0]==nodeid),axis=0)#删除已访问的结点
    for i in range(np.size(index,0)):
        if initial_dist[initial_dist[:,0]==index[i],1]>=dist_matrix[nodeid][index[i]]:
            initial_dist[initial_dist[:,0]==index[i],1]=dist_matrix[nodeid][index[i]]
        else:
            continue
    
    [tempnode,tempvalue]=initial_dist[np.where(initial_dist[:,1]==np.min(initial_dist[:,1]))][0]
    tempnode=int(tempnode)
    tempvalue=int(tempvalue)
    last_dist.append([tempnode,tempvalue])
    initial_dist=np.delete(initial_dist,np.nonzero(initial_dist[:,0]==tempnode),axis=0)#删除已访问的结点
    
    while initial_dist.size>0:
        index=np.nonzero(dist_matrix[tempnode,:])[0]
        for i in range(np.size(index,0)):
            if initial_dist[initial_dist[:,0]==index[i],1]>=tempvalue+dist_matrix[tempnode][index[i]]:
                initial_dist[initial_dist[:,0]==index[i],1]=tempvalue+dist_matrix[tempnode][index[i]]
                path[index[i]]=tempnode
            else:
                continue
        tempnode,tempvalue=initial_dist[np.where(initial_dist[:,1]==np.min(initial_dist[:,1]))][0]
        tempnode=int(tempnode)
        tempvalue=int(tempvalue)
        last_dist.append([tempnode,tempvalue])
        initial_dist=np.delete(initial_dist,np.nonzero(initial_dist[:,0]==tempnode),axis=0)#删除已访问的结点
    return last_dist,path

#T,P=  shortest_value(dist_matrix,up_bound,175)  

def findroute(FinalP,nodeid,dist_matrix,up_bound):
    T,P=  shortest_value(dist_matrix,up_bound,nodeid)  
    route=[FinalP]
    tempid=route[-1]
    while P[tempid]!=nodeid:
        route.append(P[tempid])
        tempid=route[-1]
    route.append(nodeid)
    D=np.zeros((len(route)))
    D[0]=0
    for i in range(1,len(route)):
        D[i]=D[i-1]+dist_matrix[route[i-1]][route[i]]
    distance=np.sum(D)
    return route,D,distance
 
route,D,distance=findroute(2,467,dist_matrix,up_bound)#求出最终路线

import matplotlib.pyplot as plt

L=len(route)
x=np.zeros((L,1))
y=np.zeros((L,1))
for i in range(L):
    x[i]=i
    y[i]=np.random.randint(1,10)

n=np.arange(L)
fig,ax=plt.subplots()
plt.plot(x,y)
ax.scatter(x,y,c='r')
for i,txt in enumerate(n):   
    ax.annotate([route[i],D[i]],(x[i],y[i]))

    
    

    
   
   

   
   
        
        
