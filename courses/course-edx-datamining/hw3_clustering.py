#!/usr/bin/python

import os
os.path.dirname(os.path.abspath(__file__))

import sys
import numpy

data = "X_train.2.csv"
if(len(sys.argv) >= 2):
    data = sys.argv[1]
 
print(data)

def printMatrixShape(name, M):
    print(name + ": " + str(numpy.shape(M)) + " (rows,columns)")
    
def I(n):
    return numpy.matrix(numpy.identity(n))
def T(v):
    return numpy.transpose(v)
 
def printMatrix(path, matrix2print):
    f = open(path, 'w')
    shape = numpy.shape(matrix2print)
    if(len(shape) == 2):
        for row in range(0, shape[0]):
            for col in range(0, shape[1]):
                try:
                    f.write('%.5f' % matrix2print[row,col])
                except:
                    f.write('%.5f' % matrix2print[row][col])
                if(col != shape[1]-1):
                    f.write(",")
            f.write("\n")
    else:
        for col in range(0, shape[0]):
            f.write('%.5f' % matrix2print[col])
            if(col != shape[0]-1):
                f.write(",")
    f.close()
    
def summ(l,r,c):
    if len(l) == 0:
        return numpy.zeros((r,c))
    return numpy.sum(l, axis=0)

#import matplotlib
#matplotlib.use("Agg")
#import matplotlib.pyplot as plt
#import matplotlib.mlab as mlab
from scipy.stats import multivariate_normal


dataM = numpy.loadtxt(open(data, "rb"), delimiter=",", skiprows=0)
printMatrixShape("dataM", dataM)

means = numpy.mean(dataM, axis=0)
sds = numpy.std(dataM, axis=0)
maxs = numpy.max(dataM, axis=0)
mins = numpy.min(dataM, axis=0)

colors = ["r","g","b","y","black"]

def plotContour(i, centroid, params):
    delta = 0.1
    x = numpy.arange(mins[0], maxs[0], delta)
    y = numpy.arange(mins[1], maxs[1], delta)
    X, Y = numpy.meshgrid(x, y)
    Z = mlab.bivariate_normal(X, Y,
          params[0,0], params[1,1],
          centroid[0], centroid[1])
    plt.contour(X, Y, Z, colors=colors[i])
    
n = numpy.shape(dataM)[0]
d = numpy.shape(dataM)[1]
kn = 5
def getRandCentroid():
    return [numpy.random.normal(means[i],sds[i]) for i in range(0,d)]


def initCentroids():
    return [getRandCentroid()
        for ki
        in range(0,kn)]
centroids = initCentroids()
params = [numpy.diag(numpy.repeat(0.1, d)) for ki in range(0,kn)]
pika = [1.0/kn for i in range(0,kn)]

def xi(i):
    return numpy.reshape(numpy.matrix(dataM[i,:]), (1,d))
def likelihood(xi,means,sds):
    result = multivariate_normal(means,sds, allow_singular=True).pdf(numpy.array(xi)) 
    #if(result >= 0 and result <= 1):
    #    return result
    #print('warning')
    return numpy.nan_to_num(result) 
def pxigivenk(i,k):
    return likelihood(xi(i),centroids[k],params[k])
def pofk(k):
    return pika[k];
def pkgivenxi(i,k, denominator):
    numerator = pxigivenk(i,k)*pofk(k)
    if( denominator is None):
        denominator = numpy.sum([pxigivenk(i,ck)*pofk(ck) for ck in range(0,kn)])
    return numerator/denominator
def clusterColors():
    return [
        numpy.reshape(numpy.matrix([1.0,0.0,0.0]),(1,3)),
        numpy.reshape(numpy.matrix([0.0,1.0,0.0]),(1,3)),
        numpy.reshape(numpy.matrix([0.0,0.0,1.0]),(1,3)),
        numpy.reshape(numpy.matrix([1.0,0.0,1.0]),(1,3)),
        numpy.reshape(numpy.matrix([0.0,1.0,1.0]),(1,3))]
def clusterProbColors(probs):
    sums = numpy.sum(probs)
    colors = clusterColors()
    result = numpy.sum([(probs[i]/sums)*colors[i] for i in range(0,kn)],0) 
    return result[0]
def pointsColor(dataM,cM):    
    return [clusterProbColors(cM[i,:]) for i in range(0,n)]

iterations = 10
#K-Means
def indexmax(l):
    max_val = max(l)
    return l.index(max_val)
def distance(a,b):
    dot = numpy.dot(b-a, T(b-a))
    return dot*dot    
def getNearestCentroid(i):
    distances = [distance(xi(i),centroids[k]) for k in range(0,kn)]
    return indexmax(distances)

from datetime import datetime
    
print("K-Means")
centroids = initCentroids()
for i in range(0,iterations):
    print("iteration:"+ str(i) + ":" + str(datetime.now().time()))
    printMatrix("centroids-" + str(i+1) + ".csv", centroids)
    cM = numpy.zeros((n,kn))
    for row in range(0,n):
        nearestCentroid = getNearestCentroid(row)
        cM[row, nearestCentroid] = 1.0
    ksums = numpy.sum(cM, axis=0)
    for k in range(0,kn):
        for di in range(0,d):
            result = numpy.sum(dataM[:,di]*cM[:,k])/ksums[k]
            centroids[k][di] = result
    #plt.figure()
    #plt.scatter(dataM[:,0],dataM[:,1], c=pointsColor(dataM,cM))
    #for k in range(0,kn):
    #    plt.scatter(centroids[k][0],centroids[k][1], c="black")
    #plt.savefig("state_kmean_" + "{:0>2}".format(i))

import math

#EM GMM (Expectation Maximization of Gaussian Mixture Models)
print("EM GMM (Expectation Maximization of Gaussian Mixture Models)")
centroids = initCentroids()
for i in range(0,iterations):
    print("iteration:"+ str(i) + ":" + str(datetime.now().time()))
    printMatrix("pi-" + str(i + 1) + ".csv", pika)
    for k in range(0,kn):
        printMatrix("Sigma-" + str(k+1) + "-" +str(i+1) + ".csv", params[k])
    printMatrix("mu-" + str(i+1) + ".csv", centroids)
    cM = numpy.zeros((n,kn))
    print("calculating cM:" + str(datetime.now().time()))
    for row in range(0,n):
        denominator = numpy.sum([pxigivenk(i,ck)*pofk(ck) for ck in range(0,kn)])
        for k in range(0,kn):
            cM[row,k] = pkgivenxi(row,k, denominator)
    ksums = numpy.sum(cM, axis=0)
    pika = ksums/n
    pika = pika / numpy.sum(pika)
    pika = numpy.nan_to_num(pika)
    #plt.figure()
    #plt.scatter(dataM[:,0],dataM[:,1], c=pointsColor(dataM,cM))
    #for k in range(0,kn):
    #    plotContour(k, centroids[k], params[k])
    #plt.savefig("state_" + "{:0>2}".format(i))
    print("updating centroids:" + str(datetime.now().time()))
    for k in range(0,kn):
        cMk = cM[:,k]
        for di in range(0,d):
            dataMdi = dataM[:,di]
            result = numpy.sum(dataMdi*cMk)/ksums[k]
            centroids[k][di] = result
<<<<<<< HEAD
            #params[k][di] = numpy.sum((dataMdi-result)*(dataMdi-result)*cMk)/ksums[k]    
=======
            params[k][di] = numpy.sum((dataMdi-result)*(dataMdi-result)*cMk)/ksums[k]    
>>>>>>> 7f9653b1fd932acc6d49dc47ec91beb9129ff9a1
        params[k] = numpy.sum([cM[i,k]*numpy.dot(T(xi(i)-centroids[k]),(xi(i)-centroids[k])) for i in range(0,n)],0)/(ksums[k])
        centroids[k] = numpy.nan_to_num(centroids[k])
        params[k] = numpy.nan_to_num(params[k])
print("ok")