%% Create a 24-patch ColorChecker as an image file as well as an image matrix
% 6-29-2018: reviewed
% 7-16-2014: reviewed

function im = lab2colorchecker24 (labrgb24x3)

nn = size(labrgb24x3,1);
rgb24x3 = zeros(24,3);
for i = 1:nn
    [rgb out_of_gamut] = lab2srgb(labrgb24x3(i,:));
    rgb24x3(i,:) = rgb;
end

im = rgb2colorchecker24(rgb24x3);

end
