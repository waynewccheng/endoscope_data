% truth
spec_eyeone = xlsread('D50_2_24_Color_Spectrum2.xlsx');

labtruth = zeros(24,3);

% reference white
rw123 = xlsread('Reference White.xlsx');

rw = rw123(1,:);
[Xn Yn Zn xn yn zn] = spec2xyz(rw');

% index mapping from Ray to Poynton
cc2ray = [1 5 9 13 17 21 2 6 10 14 18 22 3 7 11 15 19 23 4 8 12 16 20 24];

for i = 1:24

    j = cc2ray(i);
    
    [X Y Z x y z] = spec2xyz(spec_eyeone(j,:)');

    lab = xyz2lab(X, Y, Z, Xn, Yn, Zn);

    labtruth(i,1:3) = lab;

end

save('labtruth.mat','labtruth')
