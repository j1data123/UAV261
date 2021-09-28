clear,clc,clf
%JR. JPL 
%Reynolds Number Calculator

%Assumptions
%Operating at an altitude of 1500m
    % T=278.41K p=1.0687kg/m^3 mu=17.4*10^-6 Pa*s
%Constant dynamic viscocity at altitiude and density
    %Gamma=1.4 for air R=8.314

p = 1.0687;
T = 278.41;
mu = 17.4*10^-6;
gam = 1.4;
R = 8.314;
b = 5;


c =0.6 %input('Please input a chord length in meters: ');
v =50 %input('Please input a freestream velocity in m/s: ');

if c && v > 0
    RE = (p*v*c)/(mu);
    a = sqrt(gam*R*T);
    M = v/a;
    Q = 1.25; % For a high mounted wing that doesnt fillet with the fuselage
    S = b*c;
    
    %Wing Calculations
    cfwing = 0.455/((log10(RE)^2.58)*((1+0.144*M^2)^0.65));
    ffwing = (1+(0.6/.4)*(.152)+100*((.152)^4))*(1.34*M^0.18);
    swetted = 2.15*S; % Estimation 
    cdowing = cfwing*ffwing*(swetted/2.15)*Q;
    
    
    l = 8.4;
    
    %Fuselage
    REfuse = (p*v*l)/mu;
    f = 8.4/(sqrt((4/pi)*pi));
    fffuse = .9+(5/f^1.5)+(f/400);
    swettedfuse = pi*0.8*l;
    cffuse = 0.455/((log10(REfuse)^2.58)*((1+0.144*M^2)^0.65));
    cdofuse = cffuse*fffuse*1*(swettedfuse/2.15);
    dragbuild = cdofuse + cdowing;
    
    %2d Graphs
%     graph = load ('clvsalpha.dat');
%     x = graph(:,1);
%     y = graph(:,2);
%     plot(x,y)
%     xlabel('Alpha') 
%     ylabel('Cl')
%     title('Cl vs Alpha')

%     ndgraph = load ('cdvscl.dat');
%     i = ndgraph(:,1);
%     h = ndgraph(:,2);
%     plot(i,h)
%     xlabel('Cd') 
%     ylabel('Cl')
%     title('Cl vs Cd')
    
    %3D Graphs
    AR = b^2/S;
    alat = -5.41; %degs
    anot = 0.114;
    aprime = anot/(1+((57.3*anot)/(pi*0.7*AR)));
    alpha = -6:0.5:4;
%     plot(alpha,aprime*(alpha-alat))
%     xlabel('Alpha') 
%     ylabel('CL')
%     title('CL vs Alpha')
    
    enot = 1.78*(1-0.045*(AR^0.68))-0.64;
    
    K = 1/(pi*enot*AR);
    
%      CL = [-0.25:0.1:1.5]; %Address this later
%     
%     plot(CL,dragbuild+K*CL.^2)
%     xlabel('CD') 
%     ylabel('CL')
%     title('CL vs CD')
    
    

    fprintf('The calculated Reynolds number is %g \nThe Mach number is %g',RE,M)
    
else
    disp('Please use positive values for chord length and freestream velocity.')
end




