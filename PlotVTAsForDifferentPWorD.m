nii.img = niftiread('vat_efield_left.nii');
%%
figure
PW = 90;
Ds = 2:1:6;
cmap = lines(length(Ds));
h = {};
legendStr = {};
for i = 1:length(Ds)
    s = isosurface(nii.img > activation_model_3v(PW,Ds(i))*1000);
    s = ea_smoothpatch(s,1,35);   
    h{end+1} = patch(s, 'EdgeColor', 'none', 'FaceColor', cmap(i,:), 'FaceAlpha', 0.3)
    legendStr{end+1} = ['PW = ' num2str(PW) ' Diameter = ' num2str(Ds(i)) ];
end

legend(legendStr)
title('Effect of different axon diamters')
ylim([60 90])
axis([1 100 1 100 1 100])
daspect([1 1 1])


%%
figure
PW = 30:30:120;
Ds = 3;
cmap = lines(length(PW));
h = {};
legendStr = {};
for i = 1:length(PW)
    s = isosurface(nii.img > activation_model_3v(PW(i),Ds)*1000);
    s = ea_smoothpatch(s,1,35);   
    h{end+1} = patch(s, 'EdgeColor', 'none', 'FaceColor', cmap(i,:), 'FaceAlpha', 0.3)
    legendStr{end+1} = ['PW = ' num2str(PW(i)) ' Diameter = ' num2str(Ds) ];
end

legend(legendStr)
title('Effect of different PWs for constant diamter')
ylim([60 90])
axis([1 100 1 100 1 100])
daspect([1 1 1])


%%
figure
PW =[30 60];
Ds = [2 5.7];
cmap = lines(length(PW)*length(Ds));
h = {};
legendStr = {};
c=1;
for i = 1:length(PW)
    for j = 1:length(Ds)        
        s = isosurface(nii.img > activation_model_3v(PW(i),Ds(j))*1000);
        s = ea_smoothpatch(s,1,35);
        h{end+1} = patch(s, 'EdgeColor', 'none', 'FaceColor', cmap(c,:), 'FaceAlpha', 0.3)
        legendStr{end+1} = ['PW = ' num2str(PW(i)) ' Diameter = ' num2str(Ds(j)) ];
        c=c+1;
        
    end
end

legend(legendStr)
title('Thin vs Thick Axon at Short vs Long PW')
ylim([60 90])
axis([1 100 1 100 1 100])
daspect([1 1 1])

