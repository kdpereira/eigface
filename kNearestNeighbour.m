function success = kNearestNeighbour(labels,T,X)



    distances = -1*ones(1,size(X,2));
    diff = -1*ones(size(size(T,1),size(T,2)));
     
    %searchset = find(~ismember(labels,labels(n)));
    
    diff = bsxfun(@minus,T,X);
    distances = sum(diff.^2,1);
    
    
    
   % distances(n) = inf;
    
    [sortedValues,sortIndex] = sort(distances,'ascend');
    
    
   % neighbours = label(maxIndex(1:k)) == label(n);
   
   nearest = zeros(1,4);
   
   for i = 1:k
        guess = char(labels(sortIndex(i)));
        nearest = nearest + (persons == guess(1));
        
        if(i == k)
            [maxCount person] = max(nearest);
            if(sum(maxCount == nearest) > 1)
                k = k +1;
            end
        end
   end
   
    actual = char(labels(index));
    actualIndex = find(persons == actual(1));