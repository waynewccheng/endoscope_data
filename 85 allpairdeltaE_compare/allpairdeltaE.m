function ret = allpairdeltaE (labarray)

    nn = size(labarray,1);

    result = zeros(nn*(nn-1)/2,1);

    ind = 1;
    for i = 1:nn
        for j = i+1:nn
            result(ind,1) = deltaE(labarray(i,:), labarray(j,:));
            ind = ind + 1;
        end
    end

    ret = result;

end
