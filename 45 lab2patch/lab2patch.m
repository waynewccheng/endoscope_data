
%% generate a colorchecker image based on the LAB values
% load('datain\labtruth.mat') 
% lab2patch(labcapsule)
function lab2patch (labarray)

nn = size(labarray,1);
rgb24x3 = zeros(24,3);
for i = 1:nn
    [rgb out_of_gamut] = lab2srgb(labarray(i,:));
    rgb24x3(i,:) = rgb;
end

im = rgb2colorchecker24(rgb24x3);

end
