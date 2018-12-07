
function rgb = xyY2srgb_wcc (xyY)
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
    if (find(rgblin < 0) > 0)

        
        rgblinsign = sign(rgblin);
        rgblinabs = abs(rgblin);
        rgbabs = srgblin(rgblinabs);
        rgb = rgbabs .* rgblinsign;
        return
    end
    
    if (find(rgblin > 1) > 0)
        ['overflow!!!']
        [x y z]
        rgblin * 255
    end

    % linearize
    rgb = srgblin(rgblin);

    return
        
    % helper function for xyz2srgb
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