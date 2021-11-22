function ramp = rampFunction(time,rampTime)
    ramp = (1 + cos(pi + pi*time/rampTime))/2;
    ramp(time>rampTime) = 1;
end
