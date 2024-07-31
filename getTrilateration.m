function [pos] = getTrilateration(varargin)
%TRILATERATION calculate trialteration
% input can be 2 matrix, each size 3x3 and 3x1
% containing positions and distance
% or 6 values, each representing position and distance
if nargin == 2
    if anynan(varargin{2})
        pos = [1j;1j;1j];
        return
    end
    r = varargin{2};
    positions = varargin{1};
    assert( isequal(size(r),[1,3]) && isequal(size(positions),[3,3]) );
    p21 = positions(:,2) - positions(:,1);
    p31 = positions(:,3) - positions(:,1);

    c = cross(p21, p31);
    c2 = sum(c.^2);
    u1 = cross(((sum(p21.^2)+r(1)^2-r(2)^2)*p31 - ...
     (sum(p31.^2)+r(1)^2-r(3)^2)*p21)/2,c)/c2;
    v = sqrt(r(1)^2-sum(u1.^2))*c/sqrt(c2);
    pos = positions(:,1) + u1 + v;
elseif nargin == 6
    if anynan([varargin{4}, varargin{5}, varargin{6}])
        pos = [1j;1j;1j];
        return
    end
    assert( isequal(size(varargin{1}),[3,1]) && isequal(size(varargin{2}),[3,1]) && isequal(size(varargin{3}),[3,1]) );
    assert( isequal(size(varargin{4}),[1,1]) && isequal(size(varargin{5}),[1,1]) && isequal(size(varargin{6}),[1,1]) );
    r = [varargin{4}, varargin{5}, varargin{6}];
    p21 = varargin{2} - varargin{1};
    p31 = varargin{3} - varargin{1};
    c = cross(p21, p31);
    c2 = sum(c.^2);
    u1 = cross(((sum(p21.^2)+r(1)^2-r(2)^2)*p31 - ...
         (sum(p31.^2)+r(1)^2-r(3)^2)*p21)/2,c)/c2;
    v = sqrt(r(1)^2-sum(u1.^2))*c/sqrt(c2);
    pos = varargin{1} + u1 + v;
else
    pos = [1j;1j;1j];
    fprintf("WRONG INPUT")
end
end

