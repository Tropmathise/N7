function image_RVB = eriture_RVB(image_originale)
[nbl, nbc] = size(image_originale)
image_RVB=zeros(nbl/2,nbc/2,3)
image_RVB(:,:,1)=image_originale(1:2:end,2:2:end)
image_RVB(:,:,2)=image_originale(1:2:end,1:2:end)
image_RVB(:,:,2)=image_RVB(:,:,2)+image_originale(2:2:end,2:2:end)
image_RVB(:,:,2)=image_RVB(:,:,2)*0.5
image_RVB(:,:,3)=image_originale(2:2:end,1:2:end)

