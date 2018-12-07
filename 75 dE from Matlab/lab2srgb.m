
function rgb = lab2srgb (lab)
    % lab is between 0-100
    L_star = lab(1);
    a_star = lab(2);
    b_star = lab(3);
    
    % obtain reference white from srgb2xyz([1 1 1])
    Xn = 0.9505;
    Yn = 1.0000;
    Zn = 1.0890;
    
    %Xn = Ref_white(1,1);
    %Yn = Ref_white(1,2);
    %Zn = Ref_white(1,3);

    % equations from http://en.wikipedia.org/wiki/Lab_color_space
    Y2Yn = f_inv((1/116)*(L_star+16));
    X2Xn = f_inv((1/116)*(L_star+16) + (1/500)*a_star);
    Z2Zn = f_inv((1/116)*(L_star+16) - (1/200)*b_star);

    % calculate X Y Z x y z
    X = Xn * X2Xn;
    Y = Yn * Y2Yn;
    Z = Zn * Z2Zn;
    x = X/(X+Y+Z);
    y = Y/(X+Y+Z);
    
    % from xyY to sRGB
    rgb = xyY2srgb_wcc([x y Y]) * 255;
end

function ret = f_inv (t)
    if (t > 6/29)
        ret = t .^ 3;
    else
        ret = 3 * ((6/29).^2) * (t - 4/29);
    end
end