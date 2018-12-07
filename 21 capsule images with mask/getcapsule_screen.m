%% Retrieve RGB from captured images

% sample range 
% original size 1920x1080

% the center
cx = 1920/2;
cy = 1080/2;


cx = 970;
cy = 450;

% the ROI half-size
hl = 15;
window_size = 2 * hl + 1;

% the ROI
xrange = [cx-hl:cx+hl];
yrange = [cy-hl:cy+hl];

rgbcapsule = zeros(24,3);
canvas = uint8(zeros(window_size*4,window_size*6,3));

for i = 1:24
    
    % derive the filename
    fn = sprintf('raw_image/b%02d.tif',i);    
    
    % read the image
    im = imread(fn);

    % crop the ROI
    roi = im(yrange,xrange,:);

    % calculate the average RGB
    rgb = [mean(mean(roi(:,:,1))) mean(mean(roi(:,:,2))) mean(mean(roi(:,:,3)))];
    rgbcapsule(i,1:3) = rgb;

    % create a (red) masked image to show where the ROI is
    im(yrange,xrange,1) = 255;
    im(yrange,xrange,2) = 0;
    im(yrange,xrange,3) = 0;
    
    subplot(4,6,i)
    imshow(im)    

    % stitch
    row = floor((i-1)/6);
    col = mod((i-1),6);
    posx = window_size * col + 1;
    posy = window_size * row + 1;
    canvas(posy:posy+window_size-1,posx:posx+window_size-1,:) = roi;
end

% save the result in a file
save('rgbcapsule.mat','rgbcapsule')

% save the figure
saveas(gcf,'ROI.png')

% show ROI
clf
image(canvas)
axis image
axis off
saveas(gcf,'ROI_stitched.png')

% convert RGB to LAB
labcapsule = zeros(24,3);
for i = 1:24
    labcapsule(i,1:3) = srgb2lab(rgbcapsule(i,1:3)/255);
end
save('labcapsule.mat','labcapsule')
