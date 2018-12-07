% capsule
capsuledata = xlsread('RAPID_24 Color Patch_Closeup_C7L05_20131018.xlsx');
%capsuledata = xlsread('RAPID_24 Color Patch_Closeup_C11L85_20131018.xlsx');
rgbcapsule = capsuledata(:,4:6);

% index mapping from Ray to Poynton
cc2ray = [1 5 9 13 17 21 2 6 10 14 18 22 3 7 11 15 19 23 4 8 12 16 20 24];

labcapsule = zeros(24,3);

for i = 1:24
    j = cc2ray(i);
    labcapsule(i,1:3) = srgb2lab(rgbcapsule(j,:)./255);
end

save('labcapsule.mat','labcapsule')
