function [btree, a, Tree] = btrees(p, A)


% Order of tree
% This function creates all the possible Butcher trees for any degree p
%
if p == 1
    t = tree('*');
    btree = t;
    [T] = LBT1(btree);
    lbt = T;
    fprintf('Order %d has %d Butcher tree. \n', p,length(btree));
    disp(btree.tostring)
    lbt
    
else
    
    t = tree('b');
    Tree = [t];
    temp = t;
    for i = 1:(p-1)
        [Tnew, b] =   btreegraft(temp);
        temp = Tnew;
        Tree = [Tree, Tnew];
    end
%  keyboard
    % Label the Btrees according to Butcher Weights
    btree = Tnew;
    for j = 1:length(btree)
        btree(j) = labeltrees(btree(j));
    end
    
    % Eliminate the same trees.
    bt = btree;
    lbt = [];
    for z = 1:length(btree)
        [T] = LBT1(btree(z));
        lbt = [lbt; {T}];
    end
    lbt = string(lbt);
    [a,b] = unique(lbt);
    btree = btree(b);
    disp('-------------------------------------------------------')
    fprintf('Order %d has %d Butcher trees. \n', p,length(btree));
    A = lower(A);
    if A == 'y'
        for n = 1: length(btree)
            treenumber = n
            disp(btree(n).tostring)
            a(n)
        end
        fprintf('Order %d has %d Butcher trees. \n', p,length(btree));
        disp('---------------------------------------------------')
    elseif A == 'n'
    end
end
end
