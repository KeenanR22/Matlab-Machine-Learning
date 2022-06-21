%% Self Organizing Map
clear;clc;close all

img = imread("image0706.png"); %% Import RGB 

scrn = img(350:677,450:893,:);
[x,y,z] = size(scrn); %Dimensions
figure
imshow(scrn) %what you want to analyze
title("Screened Image0706")

%%
X = double(reshape(scrn,y*x,z)); %reshape data
numclust = 4; %Number of clusters
tic
net = selforgmap([numclust,1]); %neural net
[net,tr] = train(net, X'); %train neural net
toc
icluster_som = vec2ind(net(X')); %create group index
%% 
figure %r v. g
gscatter(X(:,1),X(:,2),icluster_som);
colormap jet
title("R v. G grouped by Self-Organizing Map Clustering")
xlabel('R Contrast Values')
ylabel('B Contrast Values')
g = icluster_som/4;
t = reshape(g,x,y,1);
figure %recreated image
imshow(t)
colormap jet
title("Picture with grouped by Self-Organizing Map Clustering")

figure %recreated image
imshow(t)
colormap jet
%%
figure
silhouette(X,icluster_som')