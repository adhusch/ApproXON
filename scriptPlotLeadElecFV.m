
%figure
hold on;
h = hggroup();
fv = elfv;
for i=1:length(elfv)
   % fv(i).vertices = elfv(i).vertices(:, [2 1 3]);
    if(ismember(i, [1 2 3 4 5 6 7 8 9]))
        patch(fv(i), 'FaceColor', rgb('dimgray'), 'EdgeColor', 'none', 'Parent', h);
    else
        patch(fv(i), 'FaceColor', rgb('lightgray'), 'EdgeColor', 'none', 'Parent', h);       
    end
end
daspect([1 1 1])
camlight left
