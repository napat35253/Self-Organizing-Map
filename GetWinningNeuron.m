function r0 = GetWinningNeuron(nNeurons,w,dataset,data)

    dMin = 10^5;
    i0 = 1;
    j0 = 1;

    for i = 1:nNeurons
        for j = 1:nNeurons
            d = sqrt(sum((w(:,i,j)-dataset(data,:)').^2));

            if d < dMin
                dMin = d;
                i0 = i;
                j0 = j;
            end
        end
    end

    r0 = [i0 j0];

end

