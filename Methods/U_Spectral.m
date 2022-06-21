%% Spectral Clustering
clear;clc;close all

img = imread("image0706.png"); %% Import RGB 

scrn = img(500:677,650:893,:);
[x,y,z] = size(scrn); %Dimensions
figure
imshow(scrn) %what you want to analyze
%title("Screened Image0706")
%% Spectral Clustering of Data

X = double(reshape(scrn,y*x,z)); %reshape data
tic
[idx,V_temp,D_temp] = spectralcluster(X,13) %computes n largest eiganvalues of laplacian matrix, the number of zeros there are in d_temp corresponds to a good number of connected components
toc
%%
figure
gscatter(X(:,1), X(:,2), idx)
title('R v. G Spectral Clustering with 13 Classes') %not a great model
xlabel('R Contrast Values')
ylabel('B Contrast Values')
t = reshape(idx,x,y,1)/16;
figure
imshow(t)

%%
figure
silhouette(X,idx)