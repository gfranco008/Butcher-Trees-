

function [der, name ] = FDBT(arbol)
obj = arbol;
obj = tree(obj, 1);
p = nnodes(obj);
Leaf=obj.findleaves;
parent = [];
parentd = [];
der = []; % derivatives
c = 0;

df_order = tree(obj, 'clear'); % Generate an empty synchronized tree
iterator = obj.nodeorderiterator; % Provides the order of the tree (depthfirst)
index = 1;
for i = iterator
    df_order = df_order.set(i, ['1-',num2str(index)]);
    index = index + 1;
end

obj = df_order;

for i = Leaf
    parent = [parent obj.getparent(i)];
    % Yay, we can chop
    if parent(1) ~= '1-1'
        c = c+1;
        labelp = obj.get(parent(c));
        labelp(1) = '2';
        obje = obj.set(parent(c),labelp);
        der= [der, obje.removenode(i)];
        %disp(der(c).tostring)
        
    end
end

child = obj.getchildren(1);
child = setdiff(child,Leaf);

for j = child
    
    c= c+1;
    label = obj.get(obj.Parent(j));
    label(1) = '2';
    obje = obj.set(obj.Parent(j),label);
    der= [der, obje.removenode(j)];
    %disp(der(c).tostring)
    
    
end

stems = [2:nnodes(obj)];
stems = setdiff(stems,Leaf);

for k = stems
    child = obj.getchildren(k);
    label = obj.get(k);
    label(1) = '2';
    obje = obj.set(k,label);
    if isempty(setdiff(child,Leaf))
        % Do nothing
    else
        for m = child
            c= c+1;
            der = [der, obje.removenode(m)];
            %disp(der(c).tostring)
            
        end
    end
end



for n = 1:length(der)
    mata = der(n);
    for m = 1:nnodes(mata)
        label = mata.get(m);
        if label(1) == '1'
            hijos = mata.getchildren(m);
            %             if isempty(hijos)
            %
            %             end
            if ~isempty(hijos)
                for q = hijos
                    labelc = mata.get(q);
                    if labelc(1) == '1'
                        label(1) = '2';
                        matac = mata.set(m,label);
                        c= c+1;
                        der = [der, matac.removenode(q)];
                        %disp(der(c).tostring)
                    end
                end
            end
        end
    end
end
[der] = uniquetree(der);
%der = Tre;
[der] = labelderivtree(der);
der = [arbol, der];
lbt = [];
[T, K,density] = LBT(der(1));
%lbt = [{T}];

for z = 1:length(der)
    [T] = LBT(der(z));
    lbt = [lbt; {T}];
end
%lbt = string(lbt);

%disp(arbol.tostring)
name = [];
fprintf('This Butcher tree has %d derivatives. \n', length(der)-1);
for n = 1: length(der)
    n
    disp(der(n).tostring)
    %string(lbt(n))
    name = [name,'+', lbt(n)];
   
end

name(1) = [];
name = [name ,'= 1 /' ,num2str(density)];
name = strjoin(name)
disp('--------------------------------------------------')
end




% %% Check for more than one node derivative
% for i = 1:length(der)
%     %%%%%%%%%% Check for chat %%%%%%%%%%%%%
%     if ~isempty(find(der(i) == "chat"))
%         for j = find(der(i) == "chat")
%             parentd = der(i).getparent(j);
%             parentofp = der(i).getparent(parentd);
%             %have to check if the grand and child are hats or not.... forgot to do
%             %that
%             pd = der(i).get(parentd);
%             ppd = der(i).get(parentofp);
%
%             if or(or(string(pd) == "bhat", string(pd) == "Ahat"),...
%                     or(string(ppd) == "bhat", string(ppd) == "Ahat"))
%             else
%                 % Yay, we can chop
%                 derd = der(i).set(parentofp,'Ahat');
%                 der= [der, derd.removenode(parentd)];
%
%                 disp(der(c).tostring)
%                 c = c+1
%             end
%         end
%     end
% end
% %%%%%%%%%%% Check for bhat %%%%%%%%%%%
%
% for i = 1:length(der)
%     if ~isempty(find(der(i) == "bhat"))
%         childb = der(i).getchildren(1);
%         for m = childb
%             grandson = der(i).getchildren(m);
%             childa = der(i).get(m);
%             for n = grandson
%                 grandsona = der(i).get(n);
%                 if or(or(string(childa) == "chat", string(childa) == "Ahat"),...
%                         or(string(grandsona) == "chat", string(grandsona) == "Ahat"))
%                 else
%                     if der(i).isleaf(n)
%                         derr = der(i).set(n,'chat');
%                         der = [der, derr.removenode(m)];
%                         disp(der(c).tostring)
%                         c = c+1
%                     else
%                         derr = der(i).set(n, 'Ahat');
%                         der = [der, derr.removenode(m)];
%                         disp(der(c).tostring)
%                         c = c+1
%                     end
%                 end
%             end
%         end
%     end
% end
% %%%%%%%%% Check for Ahat %%%%%%%%%%%%%%%%%
% for i = 1:length(der)
%
%     if ~isempty(find(der(i) == "A"))
%         for n = find(der(i) == "A")
%             hijo = der(i).getchildren(n);
%             for m = hijo
%                 if der(i).get(m) == "A"
%                     derr = der(i).set(m,'Ahat');
%                     der = [der, derr.removenode(n)];
%                     disp(der(c).tostring)
%                     c = c+1
%                 end
%             end
%         end
%     end
%
%
%
%     %% Check for more than one node derivative
% for i = 1:length(der)
%     %%%%%%%%%% Check for chat %%%%%%%%%%%%%
%     if ~isempty(find(der(i) == "chat"))
%         for j = find(der(i) == "chat")
%             parentd = der(i).getparent(j);
%             parentofp = der(i).getparent(parentd);
%             %have to check if the grand and child are hats or not.... forgot to do
%             %that
%             pd = der(i).get(parentd);
%             ppd = der(i).get(parentofp);
%
%             if or(or(string(pd) == "bhat", string(pd) == "Ahat"),...
%                     or(string(ppd) == "bhat", string(ppd) == "Ahat"))
%             else
%                 % Yay, we can chop
%                 derd = der(i).set(parentofp,'Ahat');
%                 der= [der, derd.removenode(parentd)];
%
%                 disp(der(c).tostring)
%                 c = c+1
%             end
%         end
%     end
% end
% %%%%%%%%%%% Check for bhat %%%%%%%%%%%
%
% for i = 1:length(der)
%     if ~isempty(find(der(i) == "bhat"))
%         childb = der(i).getchildren(1);
%         for m = childb
%             grandson = der(i).getchildren(m);
%             childa = der(i).get(m);
%             for n = grandson
%                 grandsona = der(i).get(n);
%                 if or(or(string(childa) == "chat", string(childa) == "Ahat"),...
%                         or(string(grandsona) == "chat", string(grandsona) == "Ahat"))
%                 else
%                     if der(i).isleaf(n)
%                         derr = der(i).set(n,'chat');
%                         der = [der, derr.removenode(m)];
%                         disp(der(c).tostring)
%                         c = c+1
%                     else
%                         derr = der(i).set(n, 'Ahat');
%                         der = [der, derr.removenode(m)];
%                         disp(der(c).tostring)
%                         c = c+1
%                     end
%                 end
%             end
%         end
%     end
%end
%%%%%%%%% Check for Ahat %%%%%%%%%%%%%%%%%
% % for i = 1:length(der)
% %
% %     if ~isempty(find(der(i) == "A"))
% %         for n = find(der(i) == "A")
% %             hijo = der(i).getchildren(n);
% %             for m = hijo
% %                 if der(i).get(m) == "A"
% %                     derr = der(i).set(m,'Ahat');
% %                     der = [der, derr.removenode(n)];
% %                     disp(der(c).tostring)
% %                     c = c+1
% %                 end
% %             end
% %         end
% %     end
% %
% %
% % end




































