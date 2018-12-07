
%% Convert LAB to sRGB
% 6-30-2018

function [rgb out_of_gamut] = lab2srgb (lab)

% lab is between 0-100
L_star = lab(1);
a_star = lab(2);
b_star = lab(3);

% white point of sRGB, D65
% https://en.wikipedia.org/wiki/CIELAB_color_space
Xn = 0.9505;
Yn = 1.0000;
Zn = 1.0890;

% equations from http://en.wikipedia.org/wiki/Lab_color_space
X2Xn = f_inv((1/116)*(L_star+16) + (1/500)*a_star);
Y2Yn = f_inv((1/116)*(L_star+16));
Z2Zn = f_inv((1/116)*(L_star+16) - (1/200)*b_star);

% calculate X Y Z x y z
X = Xn * X2Xn;
Y = Yn * Y2Yn;
Z = Zn * Z2Zn;
x = X/(X+Y+Z);
y = Y/(X+Y+Z);

% from xyY to sRGB
[rgb out_of_gamut] = xyY2srgb_wcc([x y Y]);
rgb = rgb .* 255;

return


    function ret = f_inv (t)
        if (t > 6/29)
            ret = t .^ 3;
        else
            ret = 3 * ((6/29).^2) * (t - 4/29);
        end
    end

end

