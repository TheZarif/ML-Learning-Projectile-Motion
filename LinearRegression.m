data = load('train.csv');

% Define x, y and t
y = data(:,3);
y1 = data(1:end-2,3);
y2 = data(2:end-1,3);
y3 = data(3:end,3);

t = data(:,1);
temp = size(data);
len = temp(1);
vec1 = ones(1,len-2,'double');

x = data(:,2);
x1 = data(1:end-2,2);
x2 = data(2:end-1,2);
x3 = data(3:end,2);

yParams = [y1 y2 vec1'];
xParams = [x1 x2];

% Calculate theta for normal equation for X
thetaX = (pinv(xParams'*xParams))*xParams'*x3;

% Calculate theta for normal equation for Y
thetaY = (pinv(yParams'*yParams))*yParams'*y3;



prx = [];
pry = [];
prx(1) = 0;
pry(1) = 0;
prx(2) = 0.707106781187;
pry(2) = 0.658106781187;

for i = 3:100
    temp_x = thetaX(1) * prx(i-2) + thetaX(2) * prx(i-1);
	temp_y = thetaY(1) * pry(i-2) + thetaY(2) * pry(i-1) + thetaY(3);
    
	if temp_y < 0
		break;
    end
    prx = [prx temp_x];
    pry = [pry temp_y];
end
len1 = length(prx);
indices = 0:len1-1;
result = [indices' prx' pry'];

dlmwrite('A1.csv', result, ',');

%prx = prx(1:i-1);
%pry = pry(1:i-1);

% Plot the data
plotData(prx,pry);
xlabel('X'); % Set the x-axis label
ylabel('Y'); % Set the y-axis label
