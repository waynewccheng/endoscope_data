%% calculate dE between truth and capsule
% 6/28/2018 revise
% use capsule print screen data
% 11-6-2013

% 10-29-2013

% index mapping from Ray to Poynton
cc2ray = [1 5 9 13 17 21 2 6 10 14 18 22 3 7 11 15 19 23 4 8 12 16 20 24];

% reference white
rw123 = xlsread('Reference White.xlsx');

rw = rw123(1,:);
[Xn Yn Zn xn yn zn] = spec2xyz(rw');

% truth
spec_eyeone = xlsread('D50_2_24_Color_Spectrum2.xlsx');

xyYall = zeros(24,3);
labtruth = zeros(24,3);
labcapsule = zeros(24,3);

% capsule
for i = 1:24

    j = cc2ray(i);
    
    [X Y Z x y z] = spec2xyz(spec_eyeone(j,:)');

    lab = xyz2lab(X, Y, Z, Xn, Yn, Zn);

    xyYall(i,1:3) = [x y Y/Yn];
    labtruth(i,1:3) = lab;

    rgb = lab2srgb(lab);
    
    if 1
        % show the patches
        subplot(4,6,i);
        showpatt(rgb(1), rgb(2), rgb(3))
    end
end

% ------------ capsule data

%capsuledata = xlsread('RAPID_24 Color Patch_Closeup_C7L05_20131018.xlsx');
%capsuledata = xlsread('RAPID_24 Color Patch_Closeup_C11L85_20131018.xlsx');
%rgbcapsule = capsuledata(:,4:6);

load labcapsule2.mat
load rgbcapsule2.mat

figure

for i = 1:24
    j = i;
    if 1
    subplot(4,6,i);
    showpatt(rgbcapsule(j,1), rgbcapsule(j,2), rgbcapsule(j,3))
    end
end


% delta E

dE = zeros(24,1);

for i=1:24
    dE(i,1) = deltaE(labtruth(i,:),labcapsule(i,:));
end




