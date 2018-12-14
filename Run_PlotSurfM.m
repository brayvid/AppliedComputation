% Plot the surface described by solution matrix M
hold off
clear
clc

xdom = [0 2];
tdom = [0 1];
dx = 0.2;
dt = 0.1;

M = [1,1.84147098480753,1.90929742682420,1.14112000805835,0.243197504692034,0.0410757253368956,0.720584501801568,1.65698659871850,1.98935824662476,1.41211848524108,0.455978889111066;0.621609968271514,1.46308095307904,1.53090739509571,0.762729976329865,-0.135192527037361,-0.337314306392727,0.342194470072172,1.27859656699002,1.61096821489264,1.03372845351259,0.0775888573812154;-0.227202094692984,0.614268890114545,0.682095332133031,-0.0860820866332688,-0.984004590001860,-1.18612636935723,-0.506617592891416,0.429784504025520,0.762156151929958,0.184916390548551,-0.771223205581919;-0.904072142016958,-0.0626011572092011,0.00522528480861695,-0.762952133956787,-1.66087463732401,-1.86299641667938,-1.18348764021721,-0.247085543298454,0.0852861046062117,-0.491953656774967,-1.44809325290771;-0.896758416334706,-0.0552874315262670,0.0125390104915368,-0.755638408274535,-1.65356091164358,-1.85568269099895,-1.17617391453314,-0.239771817615292,0.0925998302891458,-0.484639931092715,-1.44077952722364;-0.210795799430798,0.630675185377186,0.698501627395672,-0.0696757913708552,-0.967598294739219,-1.16972007409277,-0.490211297629685,0.446190799288161,0.778562447192599,0.201322685811192,-0.754816910319278;0.634692875943074,1.47616386074878,1.54399030276909,0.775812884003244,-0.122109619365347,-0.324231398720258,0.355277377743732,1.29167947465976,1.62405112256602,1.04681136118597,0.0906717650532301;0.999858636383578,1.84132962119111,1.90915606320777,1.14097864444193,0.243056141075613,0.0409343617202467,0.720443138185146,1.65684523510208,1.98921688300834,1.41197712162466,0.455837525493735;0.608351314533138,1.44982229933885,1.51764874135915,0.749471322591489,-0.148451180775737,-0.350572960131103,0.328935816332887,1.26533791324982,1.59770956115608,1.02046979977240,0.0643302036428395;-0.243544153735911,0.597926831072982,0.665753273089649,-0.102424145675968,-1.00034664904524,-1.20246842840061,-0.522959651934798,0.413442444983048,0.745814092888395,0.168574331506079,-0.787565264625300;-0.911130261883955,-0.0696592770768802,-0.00183283505899468,-0.770010253825603,-1.66793275719101,-1.87005453654638,-1.19054576008421,-0.254143663165451,0.0782279847387599,-0.499011776642874,-1.45515137277471];
        
x = xdom(1):dx:xdom(2);
t = tdom(1):dt:tdom(2);

X = meshgrid(x,t);
T = meshgrid(t,x)';

surf(X,T,M)
title('U(x,t)')
xlabel('x')
ylabel('t')
zlabel('U(x,t)')
