%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% Method for spatiotemporal wind power generation profile under           %
% hurricanes: U.S.-Caribbean super grid proposition                       %
% Rodney Itiki, Madhav Manjrekar, Silvio Giuseppe Di Santo, Cinthia Itiki %
% 2022.                                                                   %
% This code refers to a manuscript submitted to the journal               %
% Renewable and Sustainable Energy Reviews, Status: in review (Sept, 2022)%
% Matlab code is made available on GitHub repository link:                %
% https://github.com/roditiki/Repository001                               %
% GPL3-V3                                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;
feature('accel','on')
r= 6371008.8;   %[meters]   
verbose = 1;
region = "USA"     

alternative = 0;  % Hurricane/Typhoon modeling by Holland

trajectoryType = "Parabole";
if trajectoryType == "Parabole"
    alternative = 0;
    %set(0,"DefaultFigureVisible","off");  % Figuras invisíveis pois lento
end

     hurricaneCategory = 5;   %4 or 3;   (Ike was cat-2)
     PR=[5 4 3;     % Michael (2018)	Charley (2004)	Wilma (2005)
         919 941 950;        %Central Pressure cat-3 = 950
         18.52 37.04 55.56;  %RMW cat-3 = 55.56    (Ike is 64.82)
         970 975 980;
         55.56 55.56 57.412];  %RMW cat-3 onshore = 57.412 (Ike is 92.6)   
     jp = 7;   % select the trajectory of hurricane from 1 to 10 

turbineType = 'special'; % select typical for cutout 25 m/s or 'special', 40 m/s 

caso = 20;  
           % case 7  spare
           % case 8  spare
           % case 9  spare
           % case 10 spare
           % case 20 is USA WITH interconnection to Caribbean Supergrid
           % case 21 is USA WITHOUT interconnection to Caribbean Supergrid 
% colors of 10 hurricane trajectories in the map
co = [   0,    0.4470,    0.7410;
    0.8500,    0.3250,    0.0980;
    0.9290,    0.6940,    0.1250;
    0.4940,    0.1840,    0.5560;
    0.0000,    0.0000,    0.0000;
    0.3010,    0.7450,    0.9330;
    0.6350,    0.0780,    0.1840;
         0,    0.5000,         0;
    0.7500,         0,    0.7500;
    0.2500,    0.2500,    0.2500];
    trajectColor=co(jp,:)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   POPULATE TURBINES IN A MAP                            %
%  Populate Array of offshore wind turbines                               %
if region == "USA"
   % Coordinates in front of Cappe Hateras [35.159081, -75.359408]
   % Coordinates in from of Jacksonvile FL [30.303634, -80.710187]
   LaC=35.159081;
   LoC=-75.359408;
   LaD=30.303634;
   LoD=-80.710187;
   
                              % Array 2   
   LaE= 41.439191;         % Rodhe Island
   LoE= -70.674311;
   LaF= 37.222078;         % Virginia
   LoF= -75.805868; 
   
                            % Array 3   
   LaG= 47.755556;          % Washington - (North)
   LoG= -124.680542;
   LaH= 34.611117;          % California - Morro Bay (South)
   LoH= -120.647408;  
      
                           % Array 4   
   LaI= 32.290339;         % Texas - North
   LoI= -100.417739;
   LaJ= 41.000219;         % Amami City Omaha - Amami Oshima island
   LoJ= -84.492314;     
    
end

if region=="USA"   % USA has just one case, n should be fixed %%%
   
   

 
        
end

%%%%%% Array 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tpower=10;    % each turbine array is 10 MW 
% Angle between point C and D
deltaAngle = (distance(LaC,LoC,LaD,LoD));   %angle in [degree]
n = 5;   
% Distribution of n turbines array between point C and D. 
deltadeltaAngle = deltaAngle/n;
Turb_array=zeros(n, 3);  
for k=1:n
deltaLa_k = k*(LaD-LaC)/n;  % [delta Latitude degree]
deltaLo_k = k*(LoD-LoC)/n;  % [delta Longitude degree]
LakT=LaC+deltaLa_k;    %Latitude of turbine
LokT=LoC+deltaLo_k;    %Longitude of turbine
Turb_array(k,1:3)=[LakT LokT Tpower];  
labelLat = LakT;
labelLon = LokT;
end
Turb_array;     %OWF_table = [Lat Lon turbinePower]

%%%%%% Array 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tpower=10;    % each turbine array is 10 MW 
% Angle between point E and F
deltaAngle = (distance(LaE,LoE,LaF,LoF)) ;  %angle in [degree]
n2= 5;  
% Distribution of n turbines array between point C and D. 
deltadeltaAngle = deltaAngle/n2;
Turb_array2=zeros(n2, 3);  
for k=1:n2
deltaLa_k = k*(LaF-LaE)/n2;  % [delta Latitude degree]
deltaLo_k = k*(LoF-LoE)/n2;  % [delta Longitude degree]
LakT=LaE+deltaLa_k;    %Latitude of turbine
LokT=LoE+deltaLo_k;    %Longitude of turbine
Turb_array2(k,1:3)=[LakT LokT Tpower];  
labelLat = LakT;
labelLon = LokT;
end
Turb_array2;     %OWF_table = [Lat Lon turbinePower]

%%%%%% Array 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tpower=10;    % each turbine array is 10 MW 
% Angle between point E and F
deltaAngle = (distance(LaG,LoG,LaH,LoH))   %angle in [degree]
n3= 11;    
% Distribution of n turbines array between point C and D. 
deltadeltaAngle = deltaAngle/n3;
Turb_array3=zeros(n3, 3);  
for k=1:n3
deltaLa_k = k*(LaH-LaG)/n3;  % [delta Latitude degree]
deltaLo_k = k*(LoH-LoG)/n3;  % [delta Longitude degree]
LakT=LaG+deltaLa_k;    %Latitude of turbine
LokT=LoG+deltaLo_k;    %Longitude of turbine
Turb_array3(k,1:3)=[LakT LokT Tpower];  
labelLat = LakT;
labelLon = LokT;
end
Turb_array3;     %OWF_table = [Lat Lon turbinePower]


%%%%%% Array 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tpower=10;    % each turbine array is 10 MW 
% Angle between point E and F
deltaAngle = (distance(LaI,LoI,LaJ,LoJ))   %angle in [degree]
n4= 5;   
% Distribution of n turbines array between point C and D. 
deltadeltaAngle = deltaAngle/n4;
Turb_array4=zeros(n4, 3);  
for k=1:n4
deltaLa_k = k*(LaJ-LaI)/n4;  % [delta Latitude degree]
deltaLo_k = k*(LoJ-LoI)/n4;  % [delta Longitude degree]
LakT=LaI+deltaLa_k;    %Latitude of turbine
LokT=LoI+deltaLo_k;    %Longitude of turbine
Turb_array4(k,1:3)=[LakT LokT Tpower];  
labelLat = LakT;
labelLon = LokT;
end
Turb_array4;     %OWF_table = [Lat Lon turbinePower]

%%%%%% Array 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%n5= 10;   
Tpower=10;    % each turbine array is 10 MW 
Turb_array5(1,1:3)=[26.565417 -78.702523 Tpower];  %Bahamas 
Turb_array5(2,1:3)=[22.511881 -78.638524 Tpower];  % Cuba North
Turb_array5(3,1:3)=[20.651904 -74.875190 Tpower];   % Cuba East 
Turb_array5(4,1:3)=[19.759219 -72.158172 Tpower];  % Haiti
Turb_array5(5,1:3)=[18.369845 -69.254780 Tpower];  % Dominican Republic
Turb_array5(6,1:3)=[17.813980 -77.537822 Tpower];  % Jamaica  
Turb_array5(7,1:3)=[18.467404 -66.231590 Tpower];  % Puerto Rico northeast
Turb_array5(8,1:3)=[18.509169 -67.128103 Tpower];   % Puerto Rico northwest
Turb_array5(9,1:3)=[18.385191 -64.745133 Tpower];  % British Virgin Island
Turb_array5(10,1:3)=[17.695063 -64.760318 Tpower]; % U.S. Virgin (Saint Croix)
%Turb_array5(1,1:3)=[28.675432 -94.818362 Tpower]; % Site A - Turbina potencia zero
%Turb_array5(1,1:3)=[28.059888 -95.308861 Tpower]; % Site B - Turbina potencia zero
Turb_array5;     %OWF_table = [Lat Lon turbinePower]



% Populate coordinates of Rectangle OWF.
if region == "USA"
   % Block Island close to Rhode Island [41.1894261,-71.6487164]
   %LaOWF=41.1894261;
   %LoOWF=-71.6487164;

   % Charleston, West Virginia
   LaOWF=38.3433652;           % origin of the rectangle
   LoOWF=-81.7839763;
   
   LaOWF_D = 30.888958;        % angular direction AJUSTAR PARA USA
   LoOWF_D = -100.963295;  
  
   Dir_D= sqrt((LoOWF-LoOWF_D)*(LoOWF-LoOWF_D)+(LaOWF-LaOWF_D)*(LaOWF-LaOWF_D)); 
 
end 

if region=="USA"
lines = 10;           % Turbo_rect (Midwest)
columns = 5;
end

spacing = 500; % [m], linear spacing between turbines
Lo_delta=0;  % if not interconnector
La_delta=0;
spacing_angle = (360/(2*pi()*r))*spacing;
   if caso == 4  | caso == 1  % interconnector
      spacing = 0;
      Lo_delta=(LoOWF-LoOWF_D)/lines;
      La_delta=(LaOWF-LaOWF_D)/lines;      
   end
   
if region=="USA"
spacing = 10;
      Lo_delta=(LoOWF-LoOWF_D)/columns;  %lines, not columns
      La_delta=(LaOWF-LaOWF_D)/lines;   
end  
   
LaT0=LaOWF;
LoT0=LoOWF;
Turb_rect =[0 0 Tpower]; 
for li=1 : lines
   for col=1:columns
   LaTi = LaT0 - li*spacing_angle-li*La_delta;
   LoTi = LoT0 - col*spacing_angle-li*Lo_delta;
   k=k+1;
   aux = [LaTi LoTi Tpower];
   Turb_rect=[Turb_rect; aux];
   end
end

if region=="USA"
    clear Turb_rect;
    %Turb_rect =[0 0 Tpower];
    LaT0=46;
    LoT0=-105;
    k=0;
    lincolum=6;
   for lin=0:lincolum
      for colu=0:lincolum
      LaTi = LaT0 - lin*2.8;
      LoTi = LoT0 + colu*3.2;
      auxUSA = [LaTi LoTi Tpower];
      k=k+1;
      %Turb_rect = [Turb_rect; auxUSA];
      Turb_rect(k,:)=auxUSA;
      end
   end  
end  

%       Group all turbines in an single matrix of size mt x nt            %


%TurbTotal = [Turb_array5]; 
if region=="USA"
    if (caso == 20)  % WITH Caribbean Supergrid
       TurbTotal = [Turb_array; Turb_array2; Turb_array3; Turb_array4; Turb_array5; Turb_rect]; 
       %TurbTotal = [Turb_array; Turb_array2; Turb_array3; Turb_array4; Turb_rect]; 
    end
    if (caso == 21)  % WITHOUT Caribbean Supergrid
       TurbTotal = [Turb_array5]; 
    end    
   
end   

   [mtArray,ntArray]=size(Turb_array); % turbines in array are first
   [mtRect,ntRect]=size(Turb_rect); % turbines of OWF are in the end
   [mt,nt]=size(TurbTotal);          % TurbTotal has 3 columns
   mt_global=mt;
   clear Turb_array; 
   clear Turb_array2; 
   clear Turb_array3; 
   clear Turb_array4; 
   clear Turb_array5; 
%                 End of Turbine population                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%for jp=1:10

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Minimum airspeed before hurricane landfall                  %
%                                                                       %
for k=1:mt
      LakT = TurbTotal(k,1);
      LokT = TurbTotal(k,2);
      coast = load('coast.mat'); 
      TurbineIsInOnshore = inpolygon(LakT,LokT,coast.lat,coast.long);   
        if (TurbineIsInOnshore ==1) & (region == "USA")  % USA
                 VminOnshore = 5.5;            % assumption: minimum speed onshore
                 TurbTotal(k,4)=VminOnshore;
        else
                 VminOffshore = 8.51;
                 TurbTotal(k,4)=VminOffshore;
        end
        if (LokT > -102) & (LokT < -95) && (LakT > 31)& (region == "USA")& (TurbineIsInOnshore ==1)  % USA
                 VminOnshore = 8.5;
                 TurbTotal(k,4)=VminOnshore;          
        end
        if (region == "USA")& (TurbineIsInOnshore ==0) & (LakT > 32.5) %~= 1)
                 VminOffshore = 8.51;  % 7;     % National Renewable Energy Lab
                 TurbTotal(k,4)=VminOffshore;
        end
        if (region == "USA")& (TurbineIsInOnshore ==0) & (LakT < 32.51) %~= 1)
                 VminOffshore = 7.01;  % 7;     % National Renewable Energy Lab
                 TurbTotal(k,4)=VminOffshore;
        end        


end
%  TurbTotal(:,4)=TurbTotal(:,4)
%             End of minimum airspeed before hurricane landfall         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         Input of Hurricane trajectoryType: Straight or Parabole       %
%                                                                       %   
Vtr = 9.722;  %Original 9.722 m/s (Ike is 6.687 m/s)
% 8 m/s [28.8 km/h] - 9 m/s [32.4 km/h] 20m/s [72 km/h] = translational speed of hurricane eye
% 8 m/s Andrew , Vtr from 20 to 28 m/s over water of North Atlantic [49], 
% 9.722 m/s Michael2018, 9.722 m/s Charley2004, 13.333m/s Wilma2005landfall
w = Vtr*360/(2*pi()*r)   %[degree/second] = angular speed of hurricane eye



if region == "USA" & trajectoryType == "Parabole"   
    Lat1=[8.87	9.451111111	10.03222222	10.61333333	11.19444444	11.77555556	12.35666667	12.93777778	13.51888889	14.1];
    Long1 = [-53.34	-52.72333333	-52.10666667	-51.49	-50.87333333	-50.25666667	-49.64	-49.02333333	-48.40666667	-47.79];
    Latmin=  [30	    30  30	 30	30	30	30	30	30	30  ];
    Longmin= [-95.5	  -93.74	-91.98	-90.22	-88.46	-86.7	-84.94	-83.18	-81.42	-79.66 ];

    LaACircle=Lat1(jp);
    LoACircle=Long1(jp); 
       LaA =  13.679202;   % Hiting Puerto Rico % just to bypass bug 
       LoA =  -60.495106;
       LaB =  38.678683;    %reaching Wichita KS % just to bypass bug 
       LoB =  -100.100049;
end


%     End of input of Hurricane trajectoryType: Straight or Parabole    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Just opening the Map of USA Straight, USA parabole          %
%                                                                       % 
   deltaAngle = distance(LaB,LoB,LaA,LoA);  % distance command is in [degree]
   % Assuming w angular speed of hurricane, then:
   deltaTime=deltaAngle/w   ;                       % [s]
   % Distance between points in the Earth surface:
   arclen = (distance(LaB,LoB,LaA,LoA)); % distance command is in [degree]
   delta_d=deg2km(arclen)*1000;                       % distance [m]

if (region == "USA") & (trajectoryType == "Parabole")
   figure(1)

   latlim= [6.54 48];
   lonlim= [-101 -41];  
   ax = worldmap(latlim,lonlim);

   load coastlines
   geoshow(ax, coastlat, coastlon,...
   'DisplayType', 'polygon', 'FaceColor', [.45 .60 .30])
   textm(38.24, -95,'USA','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',12);
   textm(45.785316, -79.476563,'Canada','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',12);
   %textm(27.7264, -105.08,'Mexico','HorizontalAlignment','center','VerticalAlignment','middle');
   textm(17.9, -98,'Mexico','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',12);
   %textm(25.804782, -78.564135,'Bahamas','HorizontalAlignment','center','VerticalAlignment','middle');   
   %textm(21.64, -78.51,'Cuba','HorizontalAlignment','center','VerticalAlignment','middle');
   %textm(18.144674, -77.515694,'Jamaica','HorizontalAlignment','center','VerticalAlignment','middle');  
   %textm(47.109121, -79.504786,'Canada','HorizontalAlignment','center','VerticalAlignment','middle');
   %textm(19.3, -71.605227,'Haiti','HorizontalAlignment','center','VerticalAlignment','middle');
   %textm(18.0, -72.305227,'Dominican','HorizontalAlignment','center','VerticalAlignment','middle');
   %textm(16.8, -72.305227,'Republic','HorizontalAlignment','center','VerticalAlignment','middle');   
   %textm(17.260834, -66.163626,'Puerto Rico','HorizontalAlignment','center','VerticalAlignment','middle');   
   %textm(16.060834, -65.163626,'Virgin Islds','HorizontalAlignment','center','VerticalAlignment','middle');  
   textm(15.247465, -85.5,'Honduras','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',12);
   textm(12.738486, -85.265994,'Nicaragua','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',12);
   textm(9.209673, -74.704474,'Colombia','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',12);
   textm(9.088066, -67.285904,'Venezuela','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',12);
end



for k=1:mt     % Plot ALL turbines over the USA  map

         if region == "USA"  & (trajectoryType == "Parabole") 
            if  TurbTotal(k,2)> -100
                labelLat = TurbTotal(k,1);
                labelLon = TurbTotal(k,2);
                textm(labelLat, labelLon,'.','HorizontalAlignment','center','VerticalAlignment','middle','FontWeight','bold','FontSize',28,'Color', 'r');
            end
         end
end 
%                                                                         %
%   End of opening the Map of USA Straight, USA parabole                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Modeling the characteristic curve of the wind turbine (power vc speed) %
%  by fitting cs using interpolator function pchip                        %    
%   
   clear x;
   clear y;  % x = wind_speed [m/s];  y = wind_power [pu]
  
   if turbineType=="special"   %cutout 40 m/s
        x = [0, 1, 2, 2.5, 3,    4,    5, 6.5,   8, 9.5,   10, 11.3, 12.5, 14, 14.5, 15, 16, 17, 18, 20, 23, 24.5, 40, 40.001,  40.002, 40.003, 41, 42, 43, 100, 101];
        y = [0, 0, 0, 0,   0, 0.02, 0.03, 0.2, 0.4, 0.6, 0.65,  0.8, 0.95,  1,    1,  1,  1,  1,  1,  1,  1,    1,  1,      0,       0,      0,  0,  0,  0,   0,   0];
   else     %typical cutout speed 25 m/s
        x = [0, 1, 2, 2.5, 3,    4,    5, 6.5,   8, 9.5,   10, 11.3, 12.5, 14, 14.5, 15, 16, 17, 18, 20, 23, 24.5, 25, 25.001,  25.002, 25.003, 26, 30, 50, 100, 101];
        y = [0, 0, 0, 0,   0, 0.02, 0.03, 0.2, 0.4, 0.6, 0.65,  0.8, 0.95,  1,    1,  1,  1,  1,  1,  1,  1,    1,  1,      0,       0,      0,  0,  0,  0,   0,   0];
   end
   
   cs = pchip(x,y);   
   x_global=x;
   y_global=y;
%  End of modeling characteristic curve of wind turbine (power vc speed)  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %   
%             setting of hurricane simulation time                        %                           

if (region == "USA") & (trajectoryType == "Parabole")
    hurricane_time = 24*10;   % 9 days=216h; 240 hours = 10 days
end

%            End of setting of hurricane simulation time                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %   
%            Plot hurricane trajectory for USA Parabole                   %
%                                                                         %  
%                                                                         %  
if region == "USA"  & (trajectoryType == "Parabole")
       if  jp==10 % for time indication just for hurricane trajectory #10
           Lat1(11)=Lat1(10)+Lat1(10)-Lat1(9);
           Long1(11) =Long1(10)+Long1(10)-Long1(9);  
           Latmin(11)=Latmin(10)+Latmin(10)-Latmin(9);
           Longmin(11)=Longmin(10)+Longmin(10)-Longmin(9);
       end   
   for j=jp:jp+1   
       ap = (Long1(j) - Longmin(j))/((Lat1(j)*Lat1(j)-Latmin(j)*Latmin(j))-2*Latmin(j)*(Lat1(j)-Latmin(j)));
       bp = -2*ap*Latmin(j);
       cp = Long1(j) - ap*Lat1(j)*Lat1(j) + 2*ap*Latmin(j)*Lat1(j);
       Lati(1)=Lat1(j);
       Long(1)=Long1(j);   
    
       for i=1:hurricane_time   
                ti = i*3600;    %3600;              % hours = 3600[s] = 60 [min]
                if i==round(1)
                    LatiPreced = (Lati(i));
                    LotiPreced = (Long(i));
                    Lati(i)= Lat1(j);
                    Long(i)= Long1(j);
                    LaA=Lati(i);   
                    LoA=Long(i);   
                else 
                    Vtr=9.722; %8m/s % 9.722 m/s Michael2018, 9.722 m/s Charley2004, 13.333m/s Wilma2005landfall
                    wKmpH=Vtr*(1/1000)/(1/3600); %km/h
                    stepAngle=km2deg((wKmpH)*1); %time step is 1h, assuming Earth Great Circle
                    teta = (90-atand((2*ap*LatiPreced+bp)));
                    Lati(i)= LatiPreced+stepAngle*sind(teta); %step Angle for 8m/s in 1h = 28.8km
                    Long(i)=ap*Lati(i)*Lati(i)+bp*Lati(i)+cp;
                    LaB=Lati(i);   
                    LoB=Long(i); 
                    LaA=Lati(i-1);   
                    LoA=Long(i-1);   
                end
                    LatiPreced = Lati(i);
                    LongPreced = Long(i);                                         
                if (i > 3)    & (j==jp)
                    textm(Lati(i), Long(i), 'o','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',2,'color', 'k');
                    %textm(Lati(i), Long(i), 'o','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',8, 'color', 'm');
                end
                if (mod(i,10)==0) & (j==jp)   %+1)
                     iString = num2str(i);
                     textm(Lati(i), Long(i), 'o','HorizontalAlignment','center','VerticalAlignment','middle','fontweight','bold','FontSize',6, 'color','m'); 
                end

                auxLa(i)=Lati(i);
                auxLo(i)=Long(i);
                if (mod(i,10)==0) & (j==jp+1) 
                         iString = num2str(i);
                         deltaLati=Lati(i)-auxLa(i);
                         deltaLong=Long(i)-auxLo(i);
                         textm(0.2+(0.983)*Lati(i), 0.99*Long(i)-0.027*Lati(i), iString,'HorizontalAlignment','center','VerticalAlignment','middle', 'FontSize',11) 
                end                     

                if i==1 & (j==jp)
                     %deltaLati=Lati(i)-auxLa(i);
                     %deltaLong=Long(i)-auxLo(i);                
                     textm(Lati(i), Long(i), num2str(j),'HorizontalAlignment','center','VerticalAlignment','middle','fontweight','bold','FontSize',12, 'Color',trajectColor); %'r');
                     %Lai(i)=Lati(i);  % transfering to Lai, Loi for power calculation (next section)
                     %Loi(i)=Long(i);               
                end
                 if (j==jp)               
                     Lai(i)=Lati(i);  % transfering to Lai, Loi for power calculation (next section)
                     Loi(i)=Long(i);
                 end

       end   % hurricane time

   textm(Lat1(j),Long1(j),'o','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',2);
   textm(Latmin(j), Longmin(j), 'o','HorizontalAlignment','center','VerticalAlignment','middle','FontSize',2);
   %hold off   
   end
end   
%           End of Plot hurricane trajectory for USA Parabole             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %   
%              Calculation of power profile for USA Parabole              %  
%                                                                         %
if region == "USA"  & (trajectoryType == "Parabole")
   aux=0;
   Rmaxmax=0;
   Rmaxmin=10000000000;

   coast = load('coast.mat');   % **
   Vwm=zeros(mt, hurricane_time);  
   RmWarray(1:hurricane_time)=500;   
   RmaxArray(1:hurricane_time)=500;
   IsInOnshoreArray(1:hurricane_time)=0;
   PcArray(1:hurricane_time)=1000;  
    for i=1:hurricane_time        % PARA CADA PASSO DE TEMPO DE FURACAO    
  
      ti = i*3600; %3600;    % originally 3600;       % hours = 3600[s] = 60 [min
      IsInOnshore = inpolygon(Lai(i),Loi(i),coast.lat,coast.long);   
      IsInOnshoreArray(i)=IsInOnshore;
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %     Radius of minimum winds for Map of USA parabole                   %
      %                                                                       % 
      if hurricaneCategory == 5 & IsInOnshore==1    % Radius of minimum Wind speed
          RmW = 1408*1.1;
      end
      if hurricaneCategory == 4 & IsInOnshore==1    % Radius of minimum Wind speed
          RmW = 927*1.1;
      end
      if hurricaneCategory == 3  & IsInOnshore==1   % Radius of minimum Wind speed
          RmW = 585*1.1;
      end
      if hurricaneCategory == 5 & IsInOnshore==0    % Offshore Radius of minimum Wind speed
          RmW = 981*1.1;
      end
      if hurricaneCategory == 4 & IsInOnshore==0    % Offshore Radius of minimum Wind speed
          RmW = 267*1.1;
      end
      if hurricaneCategory == 3  & IsInOnshore==0   % Offshore Radius of minimum Wind speed
          RmW = 269*1.1;
      end
      RmWarray(i)= RmW;     % Array of Radius of minimum Wind speed
      %     End of Radius of minimum winds for Map of USA parabole            %
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     if (alternative ==0) & (region == "USA") & (trajectoryType == "Parabole")
            if hurricaneCategory == 5
                catCol=1;
            end; 
            if hurricaneCategory == 4
                catCol=2;
            end;      
            if hurricaneCategory == 3
                catCol=3;
            end;
            %IsInOnshore = inpolygon(Lai(i),Loi(i),coast.lat,coast.long);  
            if  Lai(i) > 41.09 & Lai(i) < 50.35 & Loi(i) <-75.65 & Loi(i) > -93.36 % Great Lakes  
               IsInOnshore =1;
            end  
            if IsInOnshore == 1  & Lai(i) > 28.5      % if onshore         
                Rmax = PR(5, catCol);
                Pc =  PR(4, catCol);
            end
            if IsInOnshore == 1  & Lai(i) < 28.501    % if onshore but small islands does not change Pc and Rmax         
                Rmax = PR(3, catCol);
                Pc =  PR(2, catCol);
            end     
            if IsInOnshore ==0                     % if offshore and Lai < 36.55  
                Rmax = PR(3, catCol);
                Pc =  PR(2, catCol);
            end       
            if Lai(i) > 36.55   &  IsInOnshore ==0    % if offshore but Lai > 36.55  
                Rmax = PR(3, catCol);
                Pc =  PR(4, catCol);
            end
     end
      RmaxArray(i)= Rmax;     % Array of Radius of minimum Wind speed   
      PcArray(i)=Pc;
       end
   RmWarrayFiltered=filter([1/3 1/3 1/3],1,RmWarray);
   RmaxArrayFiltered=filter([1/3 1/3 1/3],1,RmaxArray);
 
 for i=1:hurricane_time        % FOR EACH STEP OF HURRICANE   
  ti = i*3600; %3600;    % originally 3600;       % hours = 3600[s] = 60 [min
  %IsInOnshore = inpolygon(Lai(i),Loi(i),coast.lat,coast.long);

  IsInOnshore = IsInOnshoreArray(i);
  RmW=RmWarrayFiltered(i);
  Rmax=RmaxArrayFiltered(i); 
  Pc=PcArray(i); 

   
     Pn=1008;   % Between 1000 and 1015 %944;    % Pn = 944 milibar for Andrew [44],     
     %%%%%%% Linear decaying above North Mississipi to Cleveland %%%%%%%%%%
     if  Lai(i) > 35 & Lai(i) < 45 % & IsInOnshore == 1; % Decaying from North Mississipi to Cleveland
         Pc = Pc + (Pn-Pc)*(Lai(i) - 35)/(45-35);
     end 

     if  Lai(i) > 44.9999 % & IsInOnshore == 1;               % Above Cleveland, no hurricane. 
         Pc = Pn;
     end 
     %%%%%%% Linear decaying above North Mississipi to Cleveland %%%%%%%%%%   
  
  
  
  for k=1:mt                  % COMPUTE A POTENCIA DE TODAS AS TURBINAS
     LakT=TurbTotal(k,1);   
     LokT=TurbTotal(k,2);      
  if (alternative ==0) & (region == "USA") & (trajectoryType == "Parabole")
     % Calc of Hurricane speed in each turbine given the instantaneous distance
     hurricane_Model = 'Holland_and_Georgio';  % Holland and Georgio model    
   
     

      %Pc=922;    % Pc = 922 milibar for Andrew [44],
      phi = Lai(i);    % Phi = Lai, latitude of hurricane eye or turbine ?
      phi2=phi*2*pi()/360;
      %Rmax = exp(2.636 - 0.00005086*(Pn - Pc)^2 + 0.0394899*phi2);  %[km]
     if  Rmaxmax < Rmax
         Rmaxmax = Rmax;
     end
     if  Rmaxmin > Rmax
         Rmaxmin = Rmax;
     end    
     
     B = 1.38 + 0.00184*(Pn - Pc) - 0.00309*Rmax;
     %B = 1.6; % for Andrew [48]  
      Omega = 2*pi()/(24*60*60); % [rad/s] - OK, Omega value is right.
      phi = Lai(i);  % supposing latitude 40 degree [degree]
      f = 2*Omega*sin((phi*2*pi())/360); % where 
     LakT;       %=LaC+deltaLa_k;    %Latitude of turbine
     LokT;       %=LoC+deltaLo_k;    %Longitude of turbine
     Lai(i);        %=LaA+deltaLa_i;    %Latitude of hurricane after time ti
     Loi(i);        %=LoA+deltaLo_i;    %Longitude of hurricane after time ti
     u=size(Lai);
     u = length(Lai);
     %v=size(Loi);
     if i==u
     LaB=Lai(i)+2*(Lai(i)-Lai(i-1));        % Latitude of hurricane at destination
     LoB=Loi(i)+2*(Loi(i)-Loi(i-1));          
     else
     LaB=1.5*Lai(i+1);        % Latitude of hurricane at destination (to avoid numerical error)
     LoB=1.5*Loi(i+1);        % Longitude of hurricane at destination
     end

     LaBs=LaB-Lai(i);
     LoBs=LoB-Loi(i);
     LakTs=LakT-Lai(i);
     LokTs=LokT-Loi(i);
     Lais=0;
     Lois=0;
     LokTs=LokTs-LoBs;
     LakTs=LakTs-LaBs;    %%%%
     LoBs=0;
     if LokTs == Lois
         LokTs = LokTs - 0.0000001
     end
     if (LakTs > 0)&(LokTs > 0)
         quadrant = 1;
     end
     if (LakTs > 0)&(LokTs < 0)
         quadrant = 4;
     end
     if (LakTs < 0)&(LokTs > 0)
         quadrant = 2;
     end
     if (LakTs < 0) & (LokTs < 0)
         quadrant = 3;
     end
     a = (distance(LakT, LokT, Lai(i), Loi(i)));  % [deg]
     b = (distance(LaB, LoB, Lai(i), Loi(i)));    % [deg]
     c = (distance(LakT, LokT, LaB, LoB));  % [deg]
     a = deg2km(a);     %[km]
     b = deg2km(b);     %[km]
     if b==0
         b=0.00000001;
     end
     c = deg2km(c);     %[km]
     angleUpto180 = acos((c*c - a*a - b*b)/(-2*a*b));
     if (quadrant==1) || (quadrant==2)
         alpha = angleUpto180;
     end
     if (quadrant==3) | (quadrant==4)
        alpha = 2*pi() - angleUpto180; % [radians]
     end

     alphaM(k,i)= alpha;
     alphadegree = 0;
     alphadegree = alpha*360/(2* pi());
     % alpha = pi()/4;
     %%% page 109 Giorgio, wrong equation Vg=((B/p)*((Rmax/r_h)^B)*(Pn-Pc)*exp(-(Rmax/r_h)^B) + 0.25*(Vtr*sin(theta_tr)-r_h*fc)^2)^0.5 + 0.5*(Vtr*sin(theta_tr)-r_h*fc)
     deltaP = (Pn - Pc);
     rho = 1.225;   % [kg/m^3]  density of dry air at 20oC
     rho = 1.096;   % [kg/m^3]  density of humid air and hot air
     % at 70 °F and 14.696 psi, dry air has a density of 0.074887 lb/ft³.
     %%% Georgio´s Hurricane speed equation (Vg)
     a=a;     % instantaneous distance between eye and turbine kT [km]
     Vg1 = 0.5*(Vtr*sin(alpha) - f*a);
     Vg2 = 0.25*(Vtr*sin(alpha) - f*a)^2 + (100*B*deltaP/rho)*((Rmax/a)^B)*exp(-(Rmax/a)^B);
     % Obs: Cui´s equation is right! [] (It is 100*B*deltaP/rho, not B*delta/rho);
     Vg = Vg1 + sqrt(Vg2);
     Vw = 0.923*Vg;  % Speed Vw at 90m wind turbine height
     Vwm(k,i)=Vw;
     
     
    % if (TurbineIsInOnshore==0) & (Vw < TurbTotal(k,4))   %VminOffshore)  
   
     if (a > 491) & (a <= RmW) & (hurricaneCategory == 5) & IsInOnshore==0  %VminOffshore)           
         VwForma = -0.087620055*a+92.99;   	
         Vw = min(VwForma, Vw);   
     end
     if (a > 133) & (a <= RmW) & (hurricaneCategory == 4) & IsInOnshore==0  %VminOffshore)           
         VwForma = -0.24747395*a+72.99;	
         Vw = min(VwForma, Vw);                      
     end       
     if (a > 135) & (a <= RmW) & (hurricaneCategory == 3) & IsInOnshore==0  %VminOffshore)           
         VwForma = -0.170792398*a+52.99;	
         Vw = min(VwForma, Vw);                     
     end        
    
     
     if (a > 704) & (a <= RmW) & (hurricaneCategory == 5) & IsInOnshore==1  %VminOnshore)           
         VwForma = -0.020603615*a+34.5;	
         Vw = min(VwForma, Vw);   
     end
     if (a > 464) & (a <= RmW) & (hurricaneCategory == 4) & IsInOnshore==1  %VminOnshore)           
         VwForma = -0.029112878*a+32.5;	
         Vw = min(VwForma, Vw);                      
     end       
     if (a > 292) & (a <= RmW) & (hurricaneCategory == 3) & IsInOnshore==1  %VminOnshore)           
         VwForma = -0.04275676*a+30.5;	
         Vw = min(VwForma, Vw);                     
     end  
     
     if (Vw < TurbTotal(k,4)) | (a > RmW)  %VminOffshore)           
            Vw = TurbTotal(k,4);                                        
     end   
     Vwm(k,i)=Vw;    
     
  end
      
     % Calculation of turbine wind power based on wind speed 
     clear xq1;
     clear power;
     xq1 = 0:.01:101;
     plot(x,y,'o',xq1,ppval(cs,xq1),'-');
     power=ppval(cs,Vw);    %[p.u. value]
     Power = power*Tpower;  % [MW], each turbine 10 MW
     power_Profile(k,i) = Power;  % where i = hurricane time step and k = number of turbines
     ik=size(power_Profile);   
  end  % end of iteration on number of turbines
 end  % end of iteration of hurricane trajectory time
           Vwm(:,hurricane_time)=Vwm(:,hurricane_time-1);  
           power_Profile(:,hurricane_time)=power_Profile(:,hurricane_time-1);
end  % power profile for USA Parabole   
%                                                                         %
%          End of Calculation of power profile for USA Parabole           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aggregate power profile of each turbine to Total power of all turbines  %

  ki=size(power_Profile)
  GEN_time=zeros(1,hurricane_time);
        for taux=1:hurricane_time
            GEN_time(taux)=sum(power_Profile(:,taux));
        end
  ki=size(GEN_time)
%      End of Total power profile of all turbines for all hurricane time  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Plot hurricane Circle for USA Straight, USA Parabole,                 %
%                                                                         %
%      Plot hurricane Circle for Parabole                                 %
   if region == "USA"  & (trajectoryType == "Parabole")
       Rmaxmax=169; 
       if hurricaneCategory == 5;
           Rmax3 = 428000*3;
       end
       if hurricaneCategory == 4;
           Rmax3 = 189000*3;
       end      
       if hurricaneCategory == 3;
           Rmax3 = 160000*3;
       end       
       if hurricaneCategory ~= 5 | hurricaneCategory ~= 4 | hurricaneCategory ~= 3;
           Rmax3 = 150000*3;
       end
        
       RmaxAngle=Rmax3/(2*pi()*r);
       RmaxAngle=RmaxAngle*360;
       LaACircle=Lat1(jp);
       LoACircle=Long1(jp);

        for iCircle=1:360
            La=LaACircle+RmaxAngle*sin(iCircle); 
            Lo=LoACircle-sqrt(RmaxAngle*RmaxAngle-(La-LaACircle)*(La-LaACircle));
            Lopositive=LoACircle+sqrt(RmaxAngle*RmaxAngle-(La-LaACircle)*(La-LaACircle));   %LoA just initialCircle
            textm(La, Lo, '.','Color',trajectColor); %,'Color',trajectColor);
            textm(La,Lopositive,'.','Color',trajectColor); %,'Color',trajectColor);
        end
   end
   %      End of plot of hurricane circle for parabole                    %


%  End of plot hurricane Circle for USA Straight, USA Parabole            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%       Plot legend in the map of USA Straight, USA Parabole              %
%                                                                         %


if region == "USA"  & (trajectoryType == "Parabole")
   textm(32.763707, -67.081642,'LEGEND:','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',12);
   textm(30.753707, -69.1642,'oooooooo','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',2);
   textm(30.853707, -67.1642,'Trajectory of the eye','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',12);
   textm(29., -67.401642,'of the hurricane per hour','HorizontalAlignment','left','VerticalAlignment','middle','FontSize',12);
   textm(27.943707, -69.1642,'.','HorizontalAlignment','left','VerticalAlignment','middle','FontWeight','bold','FontSize',28,'Color', 'r');
   textm(27.043707, -67.351642,'Wind turbine','HorizontalAlignment','left', 'VerticalAlignment','middle','FontSize',12);
   latLegend=[ 34  26  26  24  32  34 ]; % Interconnector
   lonLegend=[-69.9 -70 -70 -48  -46.3 -70 ] ; 
   plotm(latLegend,lonLegend, 'Color','k','LineWidth',0.5);

end
%                                                                         %
% End of Plot legend in the map of USA Straight, USA Parabole             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%              Plot Figures with sobplots of                              %
%              (a) Power profile,                                         %
%              (b) Average airspeed in all turbines,                      %
%              (c) Maximum speed profile in a turbine                     %
%                                                                         %
% 
%figure('Name','Power profile [MW]');
[mt,nt]=size(GEN_time);
figure();
   strCat = num2str(hurricaneCategory);
   strTrack = num2str(jp); 
   strPowerProfile = strcat("Cat-",strCat," Track ",strTrack," (a) PowerProfile.txt");
   title(strPowerProfile)
subplot(3,1,1)  
plot([1:nt],GEN_time,'LineWidth',1.5);
grid on
% ax.XMinorTick = 'on'
axh=gca;
set (axh, 'GridLineStyle','-','FontSize',13);
grid minor;
%title('(a)')
%xlabel('                                                                   time [hour]')
xlabel('                                          (a)                                     time [hour]','fontweight','bold','FontName','Times New Roman','FontSize',14);
ylabel('Power [MW]','fontweight','bold','FontName','Times New Roman','FontSize',14); %,'FontType','Times New Roman') 

%pause('on')
%pause(30)   

WindAvg=zeros(1,hurricane_time);
    for taux8=1:hurricane_time
        WindAvg(taux8)=sum(Vwm(:,taux8))/mt_global;        
    end
    clear taux8;


%pause(30)   
    
    
subplot(3,1,2) 
plot([1:nt],WindAvg,'LineWidth',1.5);    
grid on
axh=gca;
set (axh, 'GridLineStyle','-','FontSize',13);
grid minor;
xlabel('                                          (b)                                     time [hour]','fontweight','bold','FontName','Times New Roman','FontSize',14);
ylabel('Mean speed [m/s]','fontweight','bold','FontName','Times New Roman','FontSize',14); %,'FontType','Times New Roman')

maximum = max(max(Vwm));
[x1,y1]=find(Vwm==maximum)
WindT3=zeros(1,hurricane_time);
x1=x1(1);
    for taux=1:hurricane_time
     WindT3(taux)=Vwm(x1,taux);
    end

subplot(3,1,3) 
plot([1:nt],WindT3,'LineWidth',1.5);
grid on
axh=gca;
set (axh, 'GridLineStyle','-','FontSize',13);
grid minor;
%title('(c)')
%xlabel('                                                                   time [hour]')
xlabel('                                          (c)                                     time [hour]','fontweight','bold','FontName','Times New Roman','FontSize',14);
ylabel('Max speed [m/s]','fontweight','bold','FontName','Times New Roman','FontSize',14); %,'FontType','Times New Roman')

fprintf("Turbine maximum speed at 90m from sea level [m/s]:");
MaxspeedOnTurbineAt90m=max(Vwm(:))
fprintf("Hurricane maximum gradient speed  [m/s]:");
HurricaneMaxGradientspeed=max(Vwm(:)/0.923)

clear Turb_array;
clear Turb_rect;
clear Vwm;
clear alphaM;
clear WindT3;
clear WindSum;
%                                                                         %
%      End of Plot power, mean airspeed and max speed profile curves      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%        Plot characteristic curve of the turbine (power vs airspeed      %
%                                                                         %
 figure();
 xq1 = 0:0.01:70;
 plot(x_global,y_global,'ks',xq1,ppval(cs,xq1),'-k','linewidth',2);   % plot once outside iteration x,y,'o', -k
 xlim([0 50])
 ylim([0 1.1])
 %title(' Wind turbine characteristic curve [10 MW]')
 xlabel('Wind speed [m/s]','fontweight','bold','FontName','Times New Roman','FontSize',18)
 ylabel('Power [p.u.]','fontweight','bold','FontName','Times New Roman','FontSize',18)
 grid on
 axh=gca;
 set (axh, 'GridLineStyle','-','fontweight','bold','FontSize',14);
 grid minor
 TurbTotal=TurbTotal;
 clear x_global;
 clear y_global;
 clear xq1;
%                                                                         % 
%    End of Plot characteristic curve of the turbine (power vs aispeed    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%     Export to txt file the power and mean speed profile curves          %
%                                                                         % 
if region == "USA"
   strCat = num2str(hurricaneCategory);
   strTrack = num2str(jp); 
   strPowerProfile = strcat("Cat-",strCat," Track ",strTrack," (a) PowerProfile.txt");
   csvwrite(strPowerProfile,GEN_time.')
   strTime = strcat("Cat-",strCat," Time",".txt");   
   csvwrite(strTime,[1:nt].') 
   strMeanSpeed = strcat("Cat-",strCat," Track ",strTrack," (b) MeanSpeed.txt");   
   csvwrite(strMeanSpeed,WindAvg.')   
   %clear WindAvg
else         %Japan"
   csvwrite('PowerProfile.txt',GEN_time.')
   csvwrite('time.txt',[1:nt].') 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
clear GEN_time;

clear all


