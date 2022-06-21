clear;clc;close all

img = imread("image0706.png"); %% Import RGB 

scrn = img(350:677,450:893,:);
[x,y,z] = size(scrn); %Dimensions
figure
imshow(scrn) %what you want to analyze
title("Screened Image0706")
%% Read In, Initialize
X = double(reshape(scrn, y*x, z));
numclust = 20  % number of clusters you guess are in the sample
%%
tic
idx = dbscan(X,.01,5); % The default distance metric is Euclidean distance
toc
%%
figure
gscatter(X(:,1),X(:,2),idx)
%%
names = reshape(idx,x,y,1)/max(idx);
figure
imshow(names)
colormap jet
%%
figure
silhouette(X, idx)
%%
max(idx)