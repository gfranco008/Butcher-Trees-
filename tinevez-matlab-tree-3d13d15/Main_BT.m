%Gustavo Franco Reynoso
%Sept 6th, 2017
% Execution Main Script

%% This script will produce butcher trees of the desired order and the formulas that accompany it.
% The arguments are [p] = Desired order
% The outputs are [btrees, names] = the butcher trees and the names that
% correspond to each
close all; clear all;

prompt = ' What order trees would you like? \n' ;
Order = input(prompt)
show = ' Do you want to display the original trees? Y/N \n';
stree = input(show, 's')
deri = ' Do you want the derivatives for each tree? Y/N \n';
Der = input(deri, 's')

p = Order;

[btrees, name, all] = btrees(p,stree);
% [all] are all the trees from p=1 to p=Order


Der = lower(Der);
if Der == 'y'
    for i = 1:length(btrees)
        T = btrees(i);
        [der, name] = FDBT(T);
    end
else
end




