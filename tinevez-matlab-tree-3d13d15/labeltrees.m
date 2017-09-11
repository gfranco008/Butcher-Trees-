function  [btree] = labeltrees(btree)
% Label the Btrees according to Butcher Weights
p = nnodes(btree(1));
%keyboard
for j = 1:length(btree)
    
    for n = 1:p
        btree(j) = btree(j).set(n, 'A'); % Stems are always A
    end
    
    leaf = btree(j).findleaves; % finds leaves
    btree(j) = btree(j).set(leaf(1),'c'); % First leaf always is C
    
    for k = 2:length(leaf)
        btree(j) = btree(j).set(leaf(k),'c'); % Other leaves c
    end
    
    btree(j) = btree(j).set(1,'b'); % Root
    
    % disp(btree(j).tostring);
    
end
end