cd ~/Documents/MATLAB/417/MP2/newimdata   %Change directory into folder where images are held
clc;
close all;
clear all;

perc_energy = 0.95;

%Load images and other important data
[T labels images numFiles, numPixels] = loadMP2Data('.jpg');

%Compute the mean
m = mean(T,2);

%Compute x-m
X = bsxfun(@minus,T,m);

%Compute the Scatter matrix
S = X'*X;

%Sort the eigenvalues
[Vec, D]=eig(S);
[sorted_values, ori_index]=sort(diag(D), 'descend');

figure;
plot(sorted_values)

title('Eigenvalues vs index');


%Get the accumulated values of eigenvalues and find the values that give
%95% energy
eig_energy = cumsum(sorted_values);

p = find(eig_energy > perc_energy*eig_energy(numFiles),1);

%Get the eigen vectors
V = Vec(:,ori_index);

%K Nearest Neighbour
k=5;

%Get the subspace
y = X*V;
y = y/norm(y);

persons = ['A', 'B', 'C', 'D'];

%Change for different experiment
%1 PCA, 2 Random Projectiin, 3 Raw image data
experiment = 3;

    success = zeros(1,4);
    
for n = 1:numFiles
    k = 5;
    
    %Get the approptiate matrix to project onto space
    [A1 A2] = getData(experiment, y(:,(1:p)),p, numPixels);
    
    diff = bsxfun(@minus,A1*X,A2*X(:,n));
    distances = sum(diff.^2,1);
    
    %Remove the current data point to make search more meaningful
    %Search is trivial with k=1 if data point is included
    distances(n) = inf;
    
    %Sort the distances to get nearest neighbours
    [sortedValues,sortIndex] = sort(distances,'ascend');
    
   %Array that counts the number of nearest neighbours 
   nearest = zeros(1,4);
   
   for i = 1:k
       %Obtain the label that the classifier has selected
        guess = char(labels(sortIndex(i)));
        %increment if guess is correct
        nearest = nearest + (persons == guess(1));
        
        %After k neighbours 
        if(i == k)
            %Get the class who was voted higher
            [maxCount person] = max(nearest);
            %check for tie breaker
            if(sum(maxCount == nearest) > 1)
                k = k +1;
            end
        end
   end
    
   %Get the actual class
    actual = char(labels(n));
    actualIndex = find(persons == actual(1));
    %Check if the classifier classified correctly
    success(person) = success(person) + (person == actualIndex);

end

disp(success);
accuracy = sum(success)/numFiles;
disp(accuracy);
 


