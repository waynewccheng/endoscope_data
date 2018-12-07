load labcapsule
load labtruth

for i = 1:24
    dE = deltaE(labcapsule(i,:), labtruth(i,:))
end
