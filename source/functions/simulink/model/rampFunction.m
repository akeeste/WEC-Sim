function ramp = rampFunction(time,rampTime)
    % This function calculates the cosine ramp function with a given time
    % series and ramp time.
    ramp = (1 + cos(pi + pi*time/rampTime))/2;
    ramp(time>rampTime) = 1;
end
