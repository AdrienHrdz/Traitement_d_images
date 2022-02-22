import numpy as np
import matplotlib.pyplot as plt
import cv2

I = cv2.imread('blobs2.png',0)
I2 = 255 - I
S = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(13,13))

dist = cv2.distanceTransform(I2,cv2.DIST_L2,3)
MAX = np.max(dist)
epsilon = 1
(red,I4) = cv2.threshold(dist, MAX-epsilon, 255,cv2.THRESH_BINARY)

#I4.astype(np.uint8)
nbCircle = cv2.connectedComponents(I4.astype(np.uint8))
print(nbCircle)
plt.figure(1)
plt.subplot(1,2,1)
plt.imshow(I4,'gray')

plt.subplot(1,2,2)
plt.imshow(dist,'gray')
plt.show()

