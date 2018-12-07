%% Create a 24-patch ColorChecker as an image file as well as an image matrix
% 6-29-2018: reviewed
% 7-16-2014: reviewed

function im = color2colorchecker24 (color24)

lab24x3 = zeros(24,3);
for i = 1:24
    lab24x3(i,:) = color24(i).lab;
end

im = lab2colorchecker24(lab24x3);

end
