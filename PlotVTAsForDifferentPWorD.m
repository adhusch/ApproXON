%nii.img = niftiread('/Users/andreas/Downloads/NoFEM_efield_right.nii');
nii = NiftiMod('/Users/andreas/Downloads/FEM_efield_right.nii');
smoothedEField = smooth3(nii.img, 'box', 9);
% note that voxsize of the nifti must be isotropic! (or everything scaled
% accordingly!)

%% Get World Coordinates Grid (Note: In this way only correct for ortogonal basis!)
minXYZ = nii.getNiftiWorldCoordinatesFromMatlabIdx([1;1;1]);
maxXYZ = nii.getNiftiWorldCoordinatesFromMatlabIdx([100;100;100]);

[X,Y,Z] = meshgrid(...
    linspace(minXYZ(1), maxXYZ(1), 100), ...
    linspace(minXYZ(2), maxXYZ(2), 100), ...
    linspace(minXYZ(3), maxXYZ(3), 100));

%cf:
% nii.transformationMatrix * ([100 100 100 1] - [1 1 1 0])'

%%
f = figure
PW = 90;
Ds = 2:1:6;
cmap = lines(length(Ds));
h = {};
legendStr = {};
for i = 1:length(Ds)
    p = subplot(1, length(Ds), i )
    s = isosurface(smoothedEField > activation_model_3v(PW,Ds(i))*1000);
    % s = smoothpatch(s,1,35); 
    h{end+1} = patch(s, 'EdgeColor', 'none', 'FaceColor', cmap(i,:), 'FaceAlpha', 0.9)
    legendStr{end+1} = ['PW = ' num2str(PW) ', D = ' num2str(Ds(i)) ];
    title(legendStr{end} )
    %ylim([60 90])
    axis([1 100 1 100 1 100])
    daspect([1 1 1])
    lighting gouraud
    camlight left
end

%legend(legendStr)
sgtitle('Effect of different axon diameters')



%%
figure
PW = 30:30:120;
Ds = 3;
cut = 50:100;

data = smoothedEField(cut,:,:);
cmap = lines(length(PW));
h = {};
legendStr = {};
plotLeadElecFV(elfv); camlight left;

for i = 1:length(PW)
    %p = subplot(1, length(PW), i ); camlight headlight;
    %     plotLeadElecFV(elfv);     title(legendStr{end} )
    
    s = isosurface(X(:,cut,:), Y(:,cut,:), Z(:,cut,:), permute(data, [2 1 3]) > activation_model_3v(PW(i),Ds)*1000);
    
    h{end+1} = patch(s, 'EdgeColor', 'none', 'FaceColor', cmap(i,:), 'FaceAlpha', 0.3)
    legendStr{end+1} = ['PW = ' num2str(PW(i)) ' Diameter = ' num2str(Ds) ];
    
    daspect([1 1 1])
    lighting gouraud
end

legend(legendStr)
sgtitle('Effect of different PWs for constant diameter')



%%
figure
hold on
PW =[30 60];
Ds = [2 5.7];
cut = 1:100;

data = smoothedEField(:,cut,:);
%data = nii.img(:,cut,:);
cmap = lines(length(PW)*length(Ds));
h = {};
legendStr = {};
c=1;
for i = 1:length(PW)
    for j = 1:length(Ds)        
        s = isosurface(X(:,cut,:), Y(:,cut,:), Z(:,cut,:), permute(data, [2 1 3]) > activation_model_3v(PW(i),Ds(j))*1000);
    %    s = ea_smoothpatch(s,1,35);
        h{end+1} = patch(s, 'EdgeColor', 'none', 'FaceColor', cmap(c,:), 'FaceAlpha', 0.9)
        legendStr{end+1} = ['PW = ' num2str(PW(i)) ' Diameter = ' num2str(Ds(j)) ];
        c=c+1;
        
    end
end

camlight left
lighting gouraud
legend(legendStr)
title('Thin vs Thick Axon at Short vs Long PW')
%ylim([60 90])
%axis([-50 50 1 100 1 100])
daspect([1 1 1])


%% Figure 2d

figure
imagesc(nii.img(:,:, 50))
hold on
PW = 90;
Ds = 2:1:6;
colormap gray
cmap = lines(length(Ds));
h = {};
legendStr = {};
for i = 1:length(Ds)
    legendStr{end+1} = ['PW = ' num2str(PW) ', D = ' num2str(Ds(i)) ];
    contour(smoothedEField(:,:,50), [activation_model_3v(PW,Ds(i))*1000  activation_model_3v(PW,Ds(i))*1000], 'LineWidth',2, 'LineColor',  cmap(i,:))
end
legend(legendStr)
title('Effect of different axon diameters')
axis square

%% Figure 2d

figure
slice=57;
sliceData = squeeze(nii.img(slice,:,:));
sliceDataSmooth = squeeze(smoothedEField(slice,:,:));
imagesc(sliceData)
hold on
PW = 30:30:240;
Ds = 3;
cmap = lines(length(PW));
colormap gray
h = {};
legendStr = {};
for i = 1:length(PW)
    legendStr{end+1} = ['PW = ' num2str(PW(i)) ', D = ' num2str(Ds)];
    contour(sliceDataSmooth, [activation_model_3v(PW(i),Ds)*1000  activation_model_3v(PW(i),Ds)*1000], 'LineWidth',2, 'LineColor',  cmap(i,:))
end
legend(legendStr)
colormap(cmapimage)
title('Effect of different PW')
axis square

%TODO simulate to efields with two (or three) voltages, all other
%parameters unchanged!
% eg 1V, 2V, 3V. the should exactly scale by 2, 3? if so, voltage is very
% easy to take into account by simply multiplying...


    

