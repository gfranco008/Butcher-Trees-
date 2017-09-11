tree1 = tree('b');tree1=tree1.addnode(1,'A');tree1=tree1.addnode(2,'A');tree1=tree1.addnode(3,'c'); %Tall Tree  1/24
tree2 = tree('b');tree2=tree2.addnode(1,'A');tree2=tree2.addnode(2,'c');tree2=tree2.addnode(1,'C');  %Tree with weight 1/8  A    
tree3 = tree('b');tree3=tree3.addnode(1,'C');tree3=tree3.addnode(1,'A');tree3=tree3.addnode(3,'c');  %Tree with weight 1/8  B    

%obj=tree1
obj=tree
%obj=tree3



Leaf=obj.findleaves;
DepthTree=obj.depthtree;
LeafWeight=cell2mat(DepthTree.Node(Leaf));
[LW,ind]=sort(LeafWeight);
Leaf=Leaf(ind);

X=findpath(obj,1,Leaf(1))
for i = 2:length(Leaf);
    P=findpath(obj,1,Leaf(i));
    X=[X,P(2:end)];
end
ButcherWeight=[];
for i= 1:obj.nnodes;
    ButcherWeight=[ButcherWeight,obj.get(X(i))];
end

%ButcherWeight1=ButcherWeight
%ButcherWeight2=ButcherWeight
ButcherWeight3=ButcherWeight
