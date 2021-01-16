function obj = qpz(a,b,c,d,flag)
%qpz returns a QCTRL poles and/or zeros
%
% Usage:
%
% cpz = QCTRL.qpz(a,b,c,d,flag)  returns a qctrl poles and/or zeros, based
% on flag value. 
% flag has 7 cases:
%if flag =0 ---> cpz will be pure integrator
%if flag =1 ---> cpz will be pure derivator
%if flag =2 ---> cpz will be 1st order pole, at value a.
%if flag =3 ---> cpz will be 2nd order pole, at value a.
%if flag =4 ---> cpz will be 2nd order zero, at value a.
%if flag =5 ---> cpz will be 1st order zero, at value a.
%if flag =6 ---> cpz will be first order transfer function with first order
%zero

s = qctrl(0,[],1);
obj = 1;
switch flag
    case 0 
        obj = 1/s;
    case 1
        obj = s;
    case 2 
        obj = 1/(s/a+1);
    case 3
        obj = 1/(s^2/a^2+2*b*s/a+1);
    case 4
        obj = s^2/a^2+2*b*s/a+1;
    case 5
        obj = s/a+1;
    case 6
        obj = (c*s+d)/(a*s+b);
end
