%% Fuzzy Cluster
%If multiple pictures, you have to import them all here and string them
%together in order to get a [n*m, x] array where n*m is the total pixel
%size of all images and x (usually 3 RGB values) is the data you are using to build
%the clustering. CLustering algorithms are generally used to build other
%supervised models for regression or classifcation. Examples could be Fuzzy
%c-means, KMeans, Gaussian Mixture, etc.

clear;clc;close all
img = imread("image0706.png"); %% Import RGB 
scrn = img(350:677,450:893,:);
[x,y,z] = size(scrn);
figure
imshow(scrn)

%%
X = double(reshape(scrn, y*x, 3));
numclust = 4;

%% Train Clustering Methods Fuzzy C-Means
tic
[centers, U] = fcm(X, numclust);  
toc
%% Indexes
% Classify each data point into the cluster with the largest membership value.
maxU = max(U);
%index1 = find(U(1,:) == maxU); <- will be done in the plot

%% Plot Results

figure
hold on
for i = 1:numclust
    scatter(X((U(i,:) == maxU),1),X(U(i,:) == maxU,2),'DisplayName',int2str(i))                     %clustered data with largest membership value based off numclust
    plot(centers(i,1),centers(i,2),'xblack','MarkerSize',15,'LineWidth',3,'HandleVisibility','off') %plots centroid (alternative is medoid which is just closest point to centroid)
end

legend('location','southeast','FontSize',10)
xlabel('R Values','FontSize',20)
ylabel('G Values','FontSize',20)
title('Fuzzy Clustering','FontSize',20)
hold off
grid on
set(gca,'TickDir','out'); set(gca,'LineWidth',2);set(gca,'FontSize',16); 

%% Converting Back to A Picture
names = zeros(y*x,1);                       %initialize
for i = 1:numclust                          %for all clusters, assign values
    names(U(i,:) == maxU) = i;
end
image = reshape(names,x,y,1)/numclust;      %normalize and reshape
figure
imshow(image)                               %show image
colormap jet
%%
figure
silhouette(X,names)


