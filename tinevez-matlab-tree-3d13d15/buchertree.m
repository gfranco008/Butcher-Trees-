function [T] = buchertree(p)
t = tree;
t = tree('*');
%for i = 0:p
if p == 1
   disp(t.tostring) 
   T=t;
   A=1;
elseif sum(p) == 2
    two = t.addnode(1, '.');
    disp(two.tostring)
    T = two;
    B=2;
elseif sum(p) == 3
    two = t.addnode(1, '.');
    threeb = two.addnode(1, '.');
    threel = two.addnode(2, '.');
    disp(threeb.tostring)
    disp(threel.tostring)
    c=3
    T = [threeb,threel];
end
end