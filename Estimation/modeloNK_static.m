function [residual, g1, g2] = modeloNK_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                     columns: variables in declaration order
%                                                     rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 17, 1);

%
% Model equations
%

Omega__ = (1-params(7))/(1-params(7)+params(7)*params(4));
psi_n_ya__ = (1+params(3))/(params(7)+params(3)+(1-params(7))*params(2));
lambda__ = (1-params(8))*(1-params(8)*params(1))/params(8)*Omega__;
kappa__ = lambda__*(params(2)+(params(7)+params(3))/(1-params(7)));
lhs =y(1);
rhs =params(1)*y(1)+kappa__*y(2);
residual(1)= lhs-rhs;
lhs =y(2);
rhs =y(2)-1/params(2)*(y(3)-y(1)-y(4));
residual(2)= lhs-rhs;
lhs =y(3);
rhs =y(1)*params(5)+y(2)*params(6)+y(7);
residual(3)= lhs-rhs;
residual(4) = y(4);
lhs =y(5);
rhs =y(3)-y(1);
residual(5)= lhs-rhs;
lhs =y(6);
rhs =psi_n_ya__*y(8);
residual(6)= lhs-rhs;
lhs =y(2);
rhs =y(9)-y(6);
residual(7)= lhs-rhs;
lhs =y(7);
rhs =y(7)*params(9)+x(1);
residual(8)= lhs-rhs;
lhs =y(8);
rhs =y(8)*params(10)+x(2);
residual(9)= lhs-rhs;
lhs =y(9);
rhs =y(8)+(1+params(7))*y(10);
residual(10)= lhs-rhs;
lhs =y(14);
rhs =y(3)*4;
residual(11)= lhs-rhs;
lhs =y(13);
rhs =y(4)*4;
residual(12)= lhs-rhs;
lhs =y(12);
rhs =y(5)*4;
residual(13)= lhs-rhs;
lhs =y(11);
rhs =y(1)*4;
residual(14)= lhs-rhs;
lhs =y(15);
rhs =y(1)*4;
residual(15)= lhs-rhs;
lhs =y(16);
rhs =y(9)-y(3)*params(11);
residual(16)= lhs-rhs;
lhs =y(17);
rhs =y(10)*4;
residual(17)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(17, 17);

  %
  % Jacobian matrix
  %

  g1(1,1)=1-params(1);
  g1(1,2)=(-kappa__);
  g1(2,1)=(-(1/params(2)));
  g1(2,3)=1/params(2);
  g1(2,4)=(-(1/params(2)));
  g1(3,1)=(-params(5));
  g1(3,2)=(-params(6));
  g1(3,3)=1;
  g1(3,7)=(-1);
  g1(4,4)=1;
  g1(5,1)=1;
  g1(5,3)=(-1);
  g1(5,5)=1;
  g1(6,6)=1;
  g1(6,8)=(-psi_n_ya__);
  g1(7,2)=1;
  g1(7,6)=1;
  g1(7,9)=(-1);
  g1(8,7)=1-params(9);
  g1(9,8)=1-params(10);
  g1(10,8)=(-1);
  g1(10,9)=1;
  g1(10,10)=(-(1+params(7)));
  g1(11,3)=(-4);
  g1(11,14)=1;
  g1(12,4)=(-4);
  g1(12,13)=1;
  g1(13,5)=(-4);
  g1(13,12)=1;
  g1(14,1)=(-4);
  g1(14,11)=1;
  g1(15,1)=(-4);
  g1(15,15)=1;
  g1(16,3)=params(11);
  g1(16,9)=(-1);
  g1(16,16)=1;
  g1(17,10)=(-4);
  g1(17,17)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],17,289);
end
end
