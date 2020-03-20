% Computes the value of the functional J[h(x)] for a given curve
% and also maximum local bed slope found in the profile
%
% Sergio Maldonado
% written in Matlab 2017b
%
% supplementary code to:
% Maldonado, S. (under review) Do beach profiles under non-breaking
% waves minimize energy dissipation?
%
% NOTES:
% -F[h] may be estimated analytically for some curves (e.g. a line), but we
% use the same numerical method below in all cases for consistency.
%
% -central finite differences (FDs) are preferred for measured profiles,
% while upwind FDs are used for all other curves. The criterion being the
% smoothness of the curve.

clear variables
clc
close all

%input data ==============================================

%beach profile:
dire  = '/some/folder/here';
file = 'some_data_file.dat';

n = 2;  % n_tau

%input data ==============================================

cd(dire)
 
ne = -3*(n + 1)/4;

pr = importdata(file);
pr = pr';

x = pr(:,1);
h = pr(:,2);

% central scheme:
% dhdx = (h(3:end) - h(1:end-2))./(x(3:end) - x(1:end-2));
% dhdx = [dhdx(1) ; dhdx ; dhdx(end)];

% upwind scheme:
dhdx = (h(2:end) - h(1:end-1))./(x(2:end) - x(1:end-1));
dhdx = [dhdx ; dhdx(end)];

L = (h.^ne).*sqrt(1 + dhdx.^2);

% functional is
F = trapz(x,L);

disp('The value of the functional is:')
disp(F)

disp('The max bed slope is:')
disp(max(dhdx))

% plots for reference:

% figure
% plot(x,h,'-k')
% title('beach profile')
% xlabel('x (m)')
% ylabel('h (m)')
% 
% figure
% plot(x,dhdx)
% title('slope of the profile dh/dx')
% xlabel('x (m)')
% ylabel('dh/dx')