function [residual, g1, g2, g3] = modeloNK_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [M_.exo_nbr by nperiods] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(17, 1);
Omega__ = (1-params(7))/(1-params(7)+params(7)*params(4));
psi_n_ya__ = (1+params(3))/(params(7)+params(3)+(1-params(7))*params(2));
lambda__ = (1-params(8))*(1-params(8)*params(1))/params(8)*Omega__;
kappa__ = lambda__*(params(2)+(params(7)+params(3))/(1-params(7)));
lhs =y(5);
rhs =params(1)*y(22)+kappa__*y(6);
residual(1)= lhs-rhs;
lhs =y(6);
rhs =y(23)-1/params(2)*(y(7)-y(22)-y(8));
residual(2)= lhs-rhs;
lhs =y(7);
rhs =y(5)*params(5)+y(6)*params(6)+y(11);
residual(3)= lhs-rhs;
lhs =y(8);
rhs =params(2)*psi_n_ya__*(y(24)-y(12));
residual(4)= lhs-rhs;
lhs =y(9);
rhs =y(7)-y(22);
residual(5)= lhs-rhs;
lhs =y(10);
rhs =psi_n_ya__*y(12);
residual(6)= lhs-rhs;
lhs =y(6);
rhs =y(13)-y(10);
residual(7)= lhs-rhs;
lhs =y(11);
rhs =params(9)*y(2)+x(it_, 1);
residual(8)= lhs-rhs;
lhs =y(12);
rhs =params(10)*y(3)+x(it_, 2);
residual(9)= lhs-rhs;
lhs =y(13);
rhs =y(12)+(1+params(7))*y(14);
residual(10)= lhs-rhs;
lhs =y(18);
rhs =y(7)*4;
residual(11)= lhs-rhs;
lhs =y(17);
rhs =y(8)*4;
residual(12)= lhs-rhs;
lhs =y(16);
rhs =y(9)*4;
residual(13)= lhs-rhs;
lhs =y(15);
rhs =y(5)*4;
residual(14)= lhs-rhs;
lhs =y(19);
rhs =4*(y(5)+y(13)-y(4)-params(11)*(y(7)-y(1)));
residual(15)= lhs-rhs;
lhs =y(20);
rhs =y(13)-y(7)*params(11);
residual(16)= lhs-rhs;
lhs =y(21);
rhs =y(14)*4;
residual(17)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(17, 26);

  %
  % Jacobian matrix
  %

  g1(1,5)=1;
  g1(1,22)=(-params(1));
  g1(1,6)=(-kappa__);
  g1(2,22)=(-(1/params(2)));
  g1(2,6)=1;
  g1(2,23)=(-1);
  g1(2,7)=1/params(2);
  g1(2,8)=(-(1/params(2)));
  g1(3,5)=(-params(5));
  g1(3,6)=(-params(6));
  g1(3,7)=1;
  g1(3,11)=(-1);
  g1(4,8)=1;
  g1(4,12)=params(2)*psi_n_ya__;
  g1(4,24)=(-(params(2)*psi_n_ya__));
  g1(5,22)=1;
  g1(5,7)=(-1);
  g1(5,9)=1;
  g1(6,10)=1;
  g1(6,12)=(-psi_n_ya__);
  g1(7,6)=1;
  g1(7,10)=1;
  g1(7,13)=(-1);
  g1(8,2)=(-params(9));
  g1(8,11)=1;
  g1(8,25)=(-1);
  g1(9,3)=(-params(10));
  g1(9,12)=1;
  g1(9,26)=(-1);
  g1(10,12)=(-1);
  g1(10,13)=1;
  g1(10,14)=(-(1+params(7)));
  g1(11,7)=(-4);
  g1(11,18)=1;
  g1(12,8)=(-4);
  g1(12,17)=1;
  g1(13,9)=(-4);
  g1(13,16)=1;
  g1(14,5)=(-4);
  g1(14,15)=1;
  g1(15,5)=(-4);
  g1(15,1)=(-(4*params(11)));
  g1(15,7)=(-(4*(-params(11))));
  g1(15,4)=4;
  g1(15,13)=(-4);
  g1(15,19)=1;
  g1(16,7)=params(11);
  g1(16,13)=(-1);
  g1(16,20)=1;
  g1(17,14)=(-4);
  g1(17,21)=1;
end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],17,676);
end
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],17,17576);
end
end
