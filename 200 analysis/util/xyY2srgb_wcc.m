
%% Convert XYZ to sRGB
% 6-29-2018
function [rgb out_of_gamut] = xyY2srgb_wcc (xyY)

% https://en.wikipedia.org/wiki/SRGB
% D65
mat = [3.2406 -1.5372 -0.4986; -0.9689 1.8758 0.0415; 0.0557 -0.2040 1.0570];

% calculate tristimulus
x = xyY(1);
y = xyY(2);
Y = xyY(3);
z = 1 - x - y;
X = x * (Y/y);
Z = z * (Y/y);

% transform
rgblin = mat * [X Y Z]';

%% check if anything less than 0, which triggers exception
if (find(rgblin < 0) > 0)
    
    % how much less than 0?
    % use -1 out of 255 as the threshold
    if (find(rgblin < -1/255) > 0)
        
        % if it is too small, then abord
        ['Out of Gamut!!! <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<']
        rgblin * 255
        
        out_of_gamut = 1;
        rgb = [-1 -1 -1];
        return
        
    else
        
        % if it is not too small, then fix it
        rgblin = max(rgblin,0);
        
    end
    
end

%% check if anything greater than 1, which triggers exception
if (find(rgblin > 1) > 0)
    
    % how much greater than 1?
    % use 256 out of 255 as the threshold
    if (find(rgblin > 256/255) > 0)
        
        % if it is too big, then abord
        ['Out of Gamut!!! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>']
        rgblin * 255
        
        out_of_gamut = 1;
        rgb = [-1 -1 -1];
        return
        
    else
        
        % if it is not too big, then fix it
        rgblin = min(rgblin,1);
        
    end
    
end

% linearize
rgb = srgblin(rgblin);
        out_of_gamut = 0;

return



%% helper function for xyz2srgb
    function c_rgb = srgblin (clin)
        a = 0.055;
        if clin <= 0.0031308
            c_rgb = clin .* 12.92;
        else
            c_rgb = power(clin,1/2.4).*(1+a) - a;
        end
        if c_rgb > 1
            ['ahhhhhhhhhhhhhh']
        end
        
        if c_rgb < 0
            ['ahhhhhhhhhhhhhh']
        end
        c_rgb = min(c_rgb,1);
        c_rgb = max(c_rgb,0);
    end

end