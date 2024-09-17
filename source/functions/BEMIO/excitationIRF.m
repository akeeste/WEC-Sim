function hydro = excitationIRF(hydro, options)
% Calculates the normalized excitation impulse response function:
% 
% 	:math:`\overline{K}_{e,i,\theta}(t) = {\frac{1}{2\pi}}\intop_{-\infty}^{\infty}{\frac{X_i(\omega,\theta)e^{i{\omega}t}}{{\rho}g}}d\omega`
% 
% Default parameters can be used by inputting [].
% See ``WEC-Sim\examples\BEMIO`` for examples of usage.
% 
% Parameters
% ----------
%     hydro : struct
%         Structure of hydro data
%     
%     tEnd : float (optional)
%         Calculation range for the IRF, where the IRF is calculated from t
%         = 0 to tEnd, and the default is 100 s
%     
%     nDt : float (optional)
%         Number of time steps in the IRF, the default is 1001 
%     
%     nDw : float (optional)
%         Number of frequency steps used in the IRF calculation
%         (hydrodynamic coefficients are interpolated to correspond), the
%         default is 1001
% 
%     wMin : float (optional)
%         Minimum frequency to use in the IRF calculation, the default is
%         the minimum frequency from the BEM data
% 
%     wMax : float (optional)
%         Maximum frequency to use in the IRF calculation, the default is
%         the maximum frequency from the BEM data
% 
%     quiet : bool (optional)
%         Flag to turn off the waitbar.
%
% Returns
% -------
%     hydro : struct
%         Structure of hydro data with excitation IRF
% 
arguments
    hydro
    options.tEnd = 100
    options.nDt = 1001
    options.nDw = 1001
    options.wMin = min(hydro.w)
    options.wMax = max(hydro.w)
    options.quiet = false;
end

if ~options.quiet
    p = waitbar(0,'Calculating excitation IRFs...');  % Progress bar
end

% Interpolate to the given t and w
t = linspace(-options.tEnd, options.tEnd, options.nDt);
w = linspace(options.wMin, options.wMax, options.nDw);  
N = sum(hydro.dof)*hydro.Nh;

% Calculate the impulse response function for excitation
n = 0;
for i = 1:sum(hydro.dof)
    for j = 1:hydro.Nh
        ex_re = interp1(hydro.w,squeeze(hydro.ex_re(i,j,:)),w);
        ex_im = interp1(hydro.w,squeeze(hydro.ex_im(i,j,:)),w);
        hydro.ex_K(i,j,:) = (1/pi)*trapz(w,ex_re.*cos(w.*t(:))-ex_im.*sin(w.*t(:)),2);
        n = n+1;
    end
    if ~options.quiet
        waitbar(n/N)
    end
end

hydro.ex_t = t;
hydro.ex_w = w;
if ~options.quiet
    close(p)
end

end
