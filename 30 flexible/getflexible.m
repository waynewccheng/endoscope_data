
% mapping from wcc to Poynton
% http://en.wikipedia.org/wiki/ColorChecker
wcc2cc = [19:24 13:18 7:12 1:6];

% sample range 
% original size 1280x1008
cx = 1280/2;
cy = 1008/2;
hl = 15;
window_size = 2 * hl + 1;
xrange = [cx-hl:cx+hl];
yrange = [cy-hl:cy+hl];


labflexible = zeros(24,3);
canvas = uint8(zeros(window_size*4,window_size*6,3));

for i = 1:24
    
    j = wcc2cc(i);    
    fn = sprintf('datain\\c%02d.jpg',j);    
    
    % read the image
    im = imread(fn);

    % crop the ROI
    roi = im(yrange,xrange,:);

    % calculate the average RGB
    rgb = [mean(mean(roi(:,:,1))) mean(mean(roi(:,:,2))) mean(mean(roi(:,:,3)))];
    rgbflexible(i,1:3) = rgb;

    % create a (red) masked image to show where the ROI is
    im(yrange,xrange,1) = 255;
    im(yrange,xrange,2) = 0;
    im(yrange,xrange,3) = 0;
    
    subplot(4,6,i)
    imshow(im)   
    
    labflexible(i,1:3) = srgb2lab(rgb/255);
    
    % stitch
    row = floor((i-1)/6);
    col = mod((i-1),6);
    posx = window_size * col + 1;
    posy = window_size * row + 1;
    canvas(posy:posy+window_size-1,posx:posx+window_size-1,:) = roi;    
end



% save the result in a file
save('rgbflexible.mat','rgbflexible')

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
save('labflexible.mat','labflexible')
