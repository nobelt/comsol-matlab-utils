%{

Copyright Nobel Truong 2019 

The following script generates an array of rectangles and 
modifies the size of the original base geomerty accordingly.
Be sure to make the appropriate physics selections afterwards. 

%} 

function recArr(geom1, numArr)
% geom1 is the geometry you are wanting to work with.
% numArr is the number of rectangles you want in your array

%% Define parameters 
% Define width and height of the rectangles which make up your 
% array. Be sure to check the units. 
width = 70; 
widthStr = strcat(num2str(width), '[um]'); 
height = 30;
heightStr = strcat(num2str(height), '[um]'); 

% Define span as the width of your rectangle and the space before 
% the start of the next rectangle. Please check units. 
span = 100; 
spanStr = strcat(num2str(span), '[um]'); 
spanCal = strcat('*', spanStr); 

diffStr = cell(1,numArr);

%% Initial Build
for k = 2:numArr-1
    str_k = num2str(k);
    str_rk = ['r', num2str(k+1)];
    diffStr{k} = str_rk;
    
    pos = [num2str(k-1), spanCal];          
    str_rk = geom1.feature.create(str_rk,'Rectangle');
    str_rk.label(['rec_',str_k]);
    str_rk.set('size', {widthStr heightStr});
    str_rk.set('pos', {pos, '0'});  
end 

%% Boolean Difference 
dif1 = geom1.feature.create('dif1', 'Difference');
dif1.selection('input').set({'r1'});
dif1.selection('input2').set(diffStr); 

%% Rebuild Rectangles 
for k = 1:numArr
    str_k = num2str(k);
    str_rk = ['r', num2str(numArr + k + 1)];
    pos = [num2str(k-1),spanCal];
    str_rk = geom1.feature.create(str_rk,'Rectangle');
    str_rk.label(['rec_',str_k,'.1']);
    str_rk.set('size', {widthStr heightStr});
    str_rk.set('pos', {pos, '0'});  
end 

end
