import numpy as np
import matplotlib.pyplot as plt
import cv2
# ouverture enleve les details clairs
# fermeture enleve les details fonce

I = cv2.imread('calculator.png',0)
S = cv2.getStructuringElement(cv2.MORPH_RECT,(5,15))

M = cv2.morphologyEx(I,cv2.MORPH_OPEN,S)

plt.figure(1)
plt.subplot(1,2,1)
plt.imshow(I,'gray')

plt.subplot(1,2,2)
plt.imshow(M,'gray')
plt.show()

