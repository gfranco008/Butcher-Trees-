function  [btree] = labelderivtree(btree)
% Label the Btrees according to derivatives and Butcher Weights

%keyboard
for j = 1:length(btree)
    p = nnodes(btree(j));
    for i = 1:p
        label = btree(j).get(i);
        if label(1) == '2'
            btree(j) = btree(j).set(i, 2);
        end
    end
    
    for n = 1:p
        if btree(j).get(n) ~= 2
            btree(j) = btree(j).set(n, 'A'); % Stems are always A
        end
    end
    
    if btree(j).get(1) == 2
        btree(j) = btree(j).set(1,'bhat'); % Root
    else
        btree(j) = btree(j).set(1,'b'); % Root
    end
    
    leaf = btree(j).findleaves; % finds leaves
    
    
    for k = leaf
        if btree(j).get(k) == 2
            btree(j) = btree(j).set(k,'chat');
        else
            btree(j) = btree(j).set(k,'c'); % Other leaves c
        end
    end
    A = find(btree(j)==2);
    if ~isempty(A)
      btree(j) = btree(j).set(A , 'Ahat');
    end
   
    %disp(btree(j).tostring);
    
end
end