import numpy as np
import matplotlib.pyplot as plt
import cv2

I = cv2.imread('Ampoule.png',0)

S = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(13,13))

Idilate = cv2.dilate(I,S,5)
Ierode = cv2.erode(I,S,5)
GradI = Idilate - Ierode
Itransfo = cv2.morphologyEx(I,cv2.MORPH_OPEN,S)

ItransfoDilate = cv2.dilate(I,S,5)
ItransfoErode = cv2.erode(I,S,5)
GradTransfo = ItransfoDilate - ItransfoErode
#cv2.imwrite('GradAmpoule.png',GradI)

plt.figure(1)
plt.subplot(1,2,1)
plt.imshow(Itransfo,'gray')

plt.subplot(1,2,2)
plt.imshow(GradTransfo,'gray')
plt.show()