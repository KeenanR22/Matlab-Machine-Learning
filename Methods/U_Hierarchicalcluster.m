clear;clc;close all
img = imread("image0706.png"); %% Import RGB 
scrn = img(550:677,600:893,:);
[x,y,z] = size(scrn);
%%
figure
imshow(scrn)
%%
X = double(reshape(scrn, x*y, 3));
%dist = pdist(X)
%%
tic
t = linkage(X);
dendrogram(t)
clust = cluster(t,'maxclust',17);
toc
%%
figure
gscatter(X(:,1),X(:,2),clust)
title('R v. G by Hierarchical Clustering with 17 classes')
silhouette(X,clust)
