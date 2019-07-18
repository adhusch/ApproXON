%% Examples on the "General Heuristic" of 0.2V/mm as proposed in the literature
%
%  Andreas Husch, University of Luxembourg, 2019
%  andreas.husch(at)uni.lu
%
load('astrom_table3_3v.mat'); % loads PW, D, T for 3V 
[activation_model_3v, gof] =  fitModel(PW, D, T);

%% Hightlight 0.2V contour in 3D 
figure
h = plot( activation_model_3v, [PW, D], T ,'Xlim', [10 240], 'YLim', [1 8]);
hold on
vd = plot3(60,7.5,0.064, '*r'); % validation data point


title('Axonal E-Field Activation Threshold for (PW,D) at 3V')

% Label axes
xlabel( 'PW [\mus]', 'Interpreter', 'Tex' );
ylabel( 'D [\mum]', 'Interpreter', 'Tex');
zlabel( 'T [V/mm]', 'Interpreter', 'Tex' );
grid on
view( 157.2, 26.3 );
caxis([0.0369 2])

hold on
x = linspace(10,240);
y = linspace(1,8);
[X,Y] = meshgrid(x,y);
Z = activation_model_3v(X,Y);
[~,hc] = contour3(X,Y,Z, [0.2 0.2], 'r', 'LineWidth', 2);

legend( [h; vd; hc], 'Model', 'Data', 'Validation Data', 'Proposed General Heuristics of 0.2V/mm', 'Location', 'NorthEast', 'Interpreter', 'none' );

f = gcf;
f.Color = 'w';
a = gca;
a.XTick = 30:30:270;


%% Altenative: Highlight "relevant" area:
%zlim([0 1])
%caxis([0.0369 0.5])

