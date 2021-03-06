function ret = xyz2lab (x, y, z, xn, yn, zn)
    lstar = 116 * helpf(y/yn) - 16;
    astar = 500 * (helpf(x/xn) - helpf(y/yn));
    bstar = 200 * (helpf(y/yn) - helpf(z/zn));
    ret=[lstar astar bstar];
    if lstar > 100
        ['exceeding in xyz2lab']
        [x y z xn yn zn lstar astar bstar]
        lstar = 100;
    end
    
    return
    
    function ys = helpf (t)
        if t > power(6/29,3)
            ys = power(t,1/3);
        else
            ys = power(29/6,2)/3*t+4/29;
        end
    end
end