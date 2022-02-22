import numpy as np
import matplotlib.pyplot as plt
import cv2

I = cv2.imread('angiogram.png',0)
S = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(25,25))

Itransfo = cv2.morphologyEx(I,cv2.MORPH_TOPHAT,S)

plt.figure(1)
plt.subplot(1,2,1)
plt.imshow(I,'gray')

plt.subplot(1,2,2)
plt.imshow(Itransfo,'gray')
plt.show()

