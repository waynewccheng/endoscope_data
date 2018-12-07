load labslide
load labtruth
load labflexible
load labcapsule

as = allpairdeltaE(labslide);
af = allpairdeltaE(labflexible);
ac = allpairdeltaE(labcapsule);
at = allpairdeltaE(labtruth);

rst = as ./ at;
rft = af ./ at;
rct = ac ./ at;

hold on
plot(rst,'r')
plot(rft,'b')
plot(rct,'g')

mean(rst)
mean(rft)
mean(rct)