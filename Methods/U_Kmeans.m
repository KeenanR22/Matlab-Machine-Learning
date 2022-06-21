clear;clc;close all

img = imread("image0706.png"); %% Import RGB 
imghsv = rgb2hsv(img);
%img = cat(6,img, imghsv);

%%
scrn = img(350:677,450:893,:);
[x,y,z] = size(scrn); %Dimensions
imghsv = reshape(imghsv(350:677,450:893,:),x*y,z);
figure
imshow(scrn(:,:,1:3)) %what you want to analyze
title("Screened Image0706")
%% Read In, Initialize
X = double(reshape(scrn, y*x, z));
numclust = 8  % number of clusters you guess are in the sample
%% Determine Optimal Number of Layers with Elbow Method 
tic
for i=1:numclust
clust(:,i) = kmeans(X,i,'emptyaction','singleton',...
        'replicate',5);
end
va = evalclusters(X,clust,'CalinskiHarabasz');
toc
figure
plot(va)
%%
sprintf("The Optimal Number of layers is %i determined by the Elbow Method",va.OptimalK)
K = va.OptimalK -1; % K number of groups
names = reshape(clust(:,K),x,y,1)/(K); 
%% Optical Contrast Identification
% Need to find the layer that corresponds to substrate, this can be done by
% selecting the choosing a screen that has substrate at the top left corner
% in this case its the group that corresponds to the (1,1) pixel in the
% image. Or names(1,1)
subgrp = names(1,1)*(va.OptimalK);
gray = rgb2gray(scrn);
gray = reshape(gray,y*x,1);

averages = [];
condiff = []; 
classes = [];
%initialize
for i = 1:(K)                                                   %choose based off of how many groupings exist
    averages(i) = sum(gray(clust(:, K) == i,:))/sum(clust(:, K) == i);      %Compute average grayvalue of each cluster
    condiff(i) = averages(i) - sum(gray(clust(:, K) == subgrp,:))/sum(clust(:, K) == subgrp); %contrast diff from substrate
    classes(i) = i/(K);
end
%% K-Means Optimal Cluster
%%% Optimal Number of Layers
figure
imshow(names)
%title("image0706, K-Means Clustering")                                             
colormap jet                                                              
%c = colorbar('Ticks',classes, 'TickLabels',condiff); %Displays contrast difference with grouping
%c.Label.String = 'Contrast Difference';
%c.Label.FontSize = 10;
%%
figure
scatter3(imghsv(:,1),imghsv(:,2),imghsv(:,3))
figure
scatter3(img(:,1),img(:,2),img(:,3))
%%
silhouette(X,clust(:,K))

