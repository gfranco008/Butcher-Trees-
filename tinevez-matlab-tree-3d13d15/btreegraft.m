
function [T, a] = btreegraft(temp)
p = nnodes(temp(1));
   % Use for recursive def
    Tnew= [];
    t = tree('*');
    for j = 1:length(temp)
        for i = 1:nnodes(temp(j))
            Tnew = [Tnew, temp(j).graft(i,t)];
        end
    end
    

    Tnew = labeltrees(Tnew);
    [T,a] = uniquetree(Tnew);
    

end
