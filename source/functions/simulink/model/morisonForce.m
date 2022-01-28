function f = allWaveMorison(z,r,vel,accel,disp,area,cd,vol,ca,time,rho,waveDir,waterDepth,k,w,A,rampTime,g,randPhase,dw,currentSpeed,currentDirection,currentDepth,currentOption,bodyMorison,typeNum)
% This function calculates the Morison element force for all wave cases.
[rr,~]  = size(r); 
[ff]    = length(w);
FMt     = zeros(rr,6);
uVt     = zeros(ff,1);
vVt     = uVt;
wVt     = vVt;
uAt     = wVt;
vAt     = uAt;
wAt     = vAt;

ramp = rampFunction(time,rampTime);

for ii = 1:rr
    % Calculate Rotation Matrix
    RotMax = [cos(disp(5))*cos(disp(6)) , cos(disp(4))*sin(disp(6)) + sin(disp(4))*sin(disp(5))*cos(disp(6)) , sin(disp(4))*sin(disp(6)) - cos(disp(4))*sin(disp(5))*sin(disp(6));...
              -cos(disp(5))*sin(disp(6)), cos(disp(4))*cos(disp(6)) -  sin(disp(4))*sin(disp(5))*sin(disp(6)), sin(disp(4))*cos(disp(6)) + cos(disp(4))*sin(disp(5))*sin(disp(6));...
              sin(disp(5))              , -sin(disp(4))*cos(disp(5))                                         , cos(disp(4))*cos(disp(5))                                        ];
    % Rotate Cartesian
    rRot    = mtimes(RotMax,r(ii,:).')';
    Dispt   = [disp(1),disp(2),disp(3)];
    ShiftCg = Dispt + rRot;
    zRot    = mtimes(RotMax,z(ii,:)')';
    % Update translational and rotational velocity
    % w refers to \omega = rotational velocity
    Velt    = [vel(4),vel(5),vel(6)];
    wxr     = cross(Velt,r(ii,:));
    %

    switch currentOption
        case 0
            currentSpeedDepth = currentSpeed;
        case 1
            if ShiftCg(3) > -currentDepth
                currentSpeedDepth = currentSpeed*(1 + ShiftCg(3)/currentDepth)^(1/7);
            else
                currentSpeedDepth = 0;
            end
        case 2
            if ShiftCg(3) > -currentDepth
                currentSpeedDepth = currentSpeed*(1 + ShiftCg(3)/currentDepth);
            else
                currentSpeedDepth = 0;
            end
        otherwise
            currentSpeedDepth = 0;
    end

    %Vel should be a column vector
    Vel2    = [vel(1),vel(2),vel(3)] + wxr + ramp*currentSpeedDepth*[cosd(currentDirection), sind(currentDirection), 0];
    
    % Update translational and rotational acceleration
    % dotw refers to \dot{\omega} = rotational acceleration
    Accelt  = [accel(4),accel(5),accel(6)];
    dotwxr  = cross(Accelt,r(ii,:));
    wxwxr   = cross(Velt,wxr);
    Accel2  = [accel(1),accel(2),accel(3)] + dotwxr + wxwxr;

    % adjust dw for regular & user import waves
    if typeNum < 20 || typeNum >= 30
        dw = 1;
    end
    
    % Calculate Orbital Velocity
    if typeNum >= 10
        for jj = 1:ff
            waveDirRad      = waveDir*pi/180;
            phaseArg        = w(jj,1)*time - k(jj,1)*(ShiftCg(1)*cos(waveDirRad) + ShiftCg(2)*sin(waveDirRad)) + randPhase(jj,1);
            
            % Vertical Variation
            kh              = k(jj,1)*waterDepth;
            kz              = k(jj,1)*ShiftCg(3);
            if kh > pi 
                % Deep Water Wave Assumption
                coeffHorz  = exp(kz);
                coeffVert  = coeffHorz;
            else
                % Shallow & Intermediate depth
                coeffHorz  = cosh(kz + kh)/cosh(kh);
                coeffVert  = sinh(kz + kh)/cosh(kh);
            end
    
            % Orbital Velocity for each individual wave component
            uVt(jj,1)       =  sqrt(A(jj,1)*dw(jj,1))*ramp*coeffHorz*cos(phaseArg)*g*k(jj,1)*(1/w(jj,1))*cos(waveDirRad);
            vVt(jj,1)       =  sqrt(A(jj,1)*dw(jj,1))*ramp*coeffHorz*cos(phaseArg)*g*k(jj,1)*(1/w(jj,1))*sin(waveDirRad);
            wVt(jj,1)       = -sqrt(A(jj,1)*dw(jj,1))*ramp*coeffVert*sin(phaseArg)*g*k(jj,1)*(1/w(jj,1));
    
            % Orbital Acceleration for each individual wave component
            uAt(jj,1)       = -sqrt(A(jj,1)*dw(jj,1))*ramp*coeffHorz*sin(phaseArg)*g*k(jj,1)*cos(waveDirRad);
            vAt(jj,1)       = -sqrt(A(jj,1)*dw(jj,1))*ramp*coeffHorz*sin(phaseArg)*g*k(jj,1)*sin(waveDirRad);
            wAt(jj,1)       = -sqrt(A(jj,1)*dw(jj,1))*ramp*coeffVert*cos(phaseArg)*g*k(jj,1);
        end

        % Sum the wave components to obtain the x, y, z orbital velocities
        uV = sum(uVt);
        uA = sum(uAt);
        vV = sum(vVt);
        vA = sum(vAt);
        wV = sum(wVt); 
        wA = sum(wAt);
    else
        % No wave case
        uV = 0;
        uA = 0;
        vV = 0;
        vA = 0;
        wV = 0;
        wA = 0;
    end

    fluidV              = [uV, vV, wV];
    fluidA              = [uA, vA, wA];

    if bodyMorison == 2
        %% Decompose Fluid Velocity
        % Tangential Velocity
        vT          = ((dot(zRot,fluidV))/(norm(zRot)^2))*zRot;
        % Normal Velocity
        vN          = fluidV-vT;
        %% Decompose Fluid Acceleration
        AT          = ((dot(zRot,fluidA))/(norm(zRot)^2))*zRot;
        % Normal Acceleration
        AN          = fluidA-AT;
        %% Decompose Body Velocity
        % Tangential Velocity
        Vel2T           = ((dot(zRot,Vel2))/(norm(zRot)^2))*zRot;       
        % Normal Velocity
        Vel2N           = Vel2-Vel2T;
        %% Decompose Body Acceleration
        Accel2T         = ((dot(zRot,Accel2))/(norm(zRot)^2))*zRot;   
        % Normal Acceleration
        Accel2N         = Accel2-Accel2T;
        %% Morison Equation
        % Forces from velocity drag
        FdN             = (1/2)*rho*cd(ii,1)*area(ii,1)*(vN-Vel2N)*norm(vN-Vel2N);                               
        FdT             = (1/2)*rho*cd(ii,2)*area(ii,2)*(vT-Vel2T)*norm(vT-Vel2T);                                          
        Fd              = FdT + FdN;
        % Forces from body acceleration inertia on the Morison Element
        FiN             = rho*vol(ii,:)*ca(ii,1)*(AN - Accel2N);            % AdiffN;
        FiT             = rho*vol(ii,:)*ca(ii,2)*(AT - Accel2T);            % AdiffT;
        Fbi             = FiN + FiT;
        % Forces from fluid acceleration inertia on the Morison Element
        Ffi             = rho*vol(ii,:)*(fluidA);
        % Summation of inertial forces on the Morison Element
        Fi              = Ffi + Fbi;
        % Total Force from the Morison Element
        F               = Fi + Fd;
    else
        %% Added inertia and drag forces
        areaRot         = abs(mtimes(area(ii,:),RotMax));
        CdRot           = mtimes(abs(cd(ii,:)),RotMax);
        CaRot           = abs(mtimes(ca(ii,:),RotMax));
        % Forces from velocity drag
        uVdiff          = uV - Vel2(1); FxuV = (1/2)*abs(uVdiff)*uVdiff*rho*CdRot(1)*areaRot(1);
        vVdiff          = vV - Vel2(2); FxvV = (1/2)*abs(vVdiff)*vVdiff*rho*CdRot(2)*areaRot(2);
        wVdiff          = wV - Vel2(3); FxwV = (1/2)*abs(wVdiff)*wVdiff*rho*CdRot(3)*areaRot(3);
        % Forces from body acceleration inertia
        uAdiff          = uA - Accel2(1); FxuA = uAdiff*rho*vol(ii,:)*CaRot(1);
        vAdiff          = vA - Accel2(2); FxvA = vAdiff*rho*vol(ii,:)*CaRot(2);
        wAdiff          = wA - Accel2(3); FxwA = wAdiff*rho*vol(ii,:)*CaRot(3);
        % Forces from fluid acceleration inertia
        FxuAf           = uA*vol(ii,:)*rho;
        FxvAf           = vA*vol(ii,:)*rho;
        FxwAf           = wA*vol(ii,:)*rho;
        % Total Force from the Morison Element
        F               = [FxuV + FxuA + FxuAf,...
                           FxvV + FxvA + FxvAf,...
                           FxwV + FxwA + FxwAf];
    end
    % Determine if the Morison Element point of application goes above the
    % mean water line and does not consider the local surface elevation.
    if ShiftCg(3) > 0
        F           = [0, 0, 0];
        M           = [0, 0, 0];
        % Calculate the moment about the center of gravity for each Morison Element
        FMt(ii,:)   = [F,M];
    else
        % Calculate the moment about the center of gravity for each Morison Element
        M           = cross(rRot,F);
        FMt(ii,:)   = [F,M];
    end
end
f      = 0.*vel;
f(1:6) = [sum(FMt(:,1));sum(FMt(:,2));sum(FMt(:,3));sum(FMt(:,4));sum(FMt(:,5));sum(FMt(:,6))];
end
