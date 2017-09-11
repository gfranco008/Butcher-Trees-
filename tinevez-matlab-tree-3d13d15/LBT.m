%% LBT converts trees into ordered weights
%This code remedies the issue of not being able to identify repeated trees.
%This uses the fact that the trees will be labeled first using the standard
%butcher practice.  The code essentially reads the labeled trees in order
%of the shortest path to the longest and concatenates the labeled sorted
%nodes into a string.
%This can be used to check If the resulting strings of two trees are equal
%then they should be considered a repetition and one of the trees should
%be deleted.
function [BW, df_order, density] = LBT1(butchertree)
 


obj=butchertree;
if nnodes(obj) == 1
    BW = "b = 1";
else
    
    Leaf=obj.findleaves; % find leaves
    DepthTree=obj.depthtree; % Draws a depth tree
    LeafWeight=cell2mat(DepthTree.Node(Leaf)); % weights of leafs
    [LW,ind]=sort(LeafWeight);
    Leaf=Leaf(ind); % sort leafs
    
    %%%%%%%%% Provides a tree with node numbering %%%%%%%%%%%%%%%%%%%%%%%%%%%%
df_order = tree(obj, 'clear'); % Generate an empty synchronized tree
iterator = obj.nodeorderiterator; % Provides the order of the tree (depthfirst)
index = 1;
for i = iterator
df_order = df_order.set(i, index);
index = index + 1;
end
%disp(df_order.tostring); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    
    ot = tree(obj, 1); % Create a copy-tree filled with ones
    density = ot.recursivecumfun(@(x) sum(x) + 1); % Calculate density
   
    %disp( [ obj.tostring  density.tostring  df_order.tostring] );
    
    
    leafc = [];
    leafgc = [];
    leafggc = [];
    
    children = obj.getchildren(1); % Children of root
    denr = [];
    den = [];
    for m = children
        denr = [denr, density.get(m)]; %sorts children in terms of density
    end
    if length(unique(denr)) == 1
        
    else
        [den,ind] = sort(denr);
        children = children(ind);
    end
    
    
    for i = children
        if obj.isleaf(i)
            leafc = [leafc, i];
            %Leaf = unique(Leaf,'stable');
        elseif not(obj.isleaf(i))
            gchildren = obj.getchildren(i);
            if length(gchildren) > 1
                den = [];
                for m = gchildren
                    den = [den, density.get(m)]; %sorts children in terms of density
                end
                if length(unique(den)) == 1
                    
                else
                    [den,ind] = sort(den);
                   % keyboard
                    gchildren = gchildren(ind);
                end
            end
            for j = gchildren
                if obj.isleaf(j)
                    leafgc = [leafgc, j];
                    %Leaf = unique(Leaf,'stable');
                else
                    ggchildren = obj.getchildren(j);
                    for k = ggchildren
                        if obj.isleaf(k)
                            leafggc = [leafggc, k];
                        end
                    end
                end
            end
        end
    end
    Leaf = [leafc, leafgc, leafggc, Leaf];
    Leaf = unique(Leaf,'stable');
    
    X=findpath(obj,1,Leaf(1));
    for i = 2:length(Leaf)
        P=findpath(obj,1,Leaf(i));
        X=[X,P];
        %X=[X,P(2:end)];
    end
    X=unique(X, 'stable');
    %keyboard
    
    ButcherWeight=[];
    for i= 1:obj.nnodes
        if or(obj.get(X(i)) == 'b',obj.get(X(i)) == 'bhat')
        ButcherWeight=['(', ButcherWeight,obj.get(X(i))];
        
        elseif or(obj.get(X(i)) == 'c', obj.get(X(i)) == 'chat')
             ButcherWeight=[ ButcherWeight,obj.get(X(i)), ')('];
             
        else
            ButcherWeight=[ ButcherWeight,obj.get(X(i))];
        end
             
    end
    ButcherWeight(end) = [];
    
    
    density = prod(cell2mat(density.Node));
    ButcherWeight = [ ButcherWeight ];
    BW=ButcherWeight;
end
end