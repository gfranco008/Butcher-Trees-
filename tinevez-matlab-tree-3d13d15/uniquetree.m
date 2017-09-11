function [btree, a] = uniquetree(btree)

% Eliminate the same trees.

lbt = [];
for z = 1:length(btree)
    [T] = LBT1(btree(z));
    lbt = [lbt; {T}];
    
end
lbt = string(lbt);
[a,b] = unique(lbt);
btree = btree(b);
end