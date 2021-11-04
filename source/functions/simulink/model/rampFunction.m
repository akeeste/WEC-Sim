function ramp = rampFunction(time,startTime,rampTime)

ramp = (sin((time-startTime)/(rampTime-startTime)*pi+3*pi/2)+1)/2;
ramp(time<startTime) = 0;
ramp(time>rampTime) = 1;

end
