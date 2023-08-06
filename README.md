# car-plate-detection

**License Plate Detection and Recognition using MATLAB - README**

**Project Description:**
License Plate Detection and Recognition is a computer vision project implemented in MATLAB. The goal of this project is to automatically detect and extract license plate regions from an input image and then recognize the alphanumeric characters on the license plate. The project utilizes various image processing techniques to achieve accurate and efficient license plate analysis.

**Requirements:**
To run this MATLAB project, you need to have the following:
1. MATLAB installed on your computer.
2. The project directory containing the provided code file and the 'Number Plate Images' folder containing the input images (e.g., 'img1.png').

**Instructions:**
1. Ensure you have MATLAB installed and set up correctly.
2. Place the provided code file in the project directory and create a subfolder named 'Number Plate Images'.
3. Place the input images (e.g., 'img1.png') inside the 'Number Plate Images' folder that you want to process.
4. Modify the 'img1.png' in the code to the filename of the specific input image you want to process, if needed.

**How the Code Works:**
1. The code reads the input image and converts it to grayscale to simplify the processing.
2. It applies a Gaussian filter to smooth out the image and then uses a median filter to remove salt and pepper noise.
3. The grayscale image is binarized to obtain a binary representation of the image.
4. Edge detection is performed using the Prewitt operator to highlight the edges in the image.
5. The edges are dilated to emphasize the regions with potential license plates.
6. The code then identifies the region with the maximum area, which is likely to be the license plate.
7. The identified license plate area is cropped from the binary image.
8. Small objects in the cropped plate area are removed based on their area.
9. The code reads the individual letters from the processed plate area using regionprops.
10. It filters out irrelevant characters (e.g., "##") and concatenates the recognized letters to form the license plate number.
11. The final license plate number is printed to the console.
12. The code then searches for the extracted license plate number in the 'numbers_plates.txt' file and prints the matching results, if any.

**Important Notes:**
1. The success of the license plate detection and recognition heavily depends on the quality and clarity of the input images. Ensure that the input images are well-captured and not too blurry.
2. The code parameters, such as the size of the structuring element in dilation and the area threshold for removing small objects, can be adjusted to fine-tune the performance on different types of images.
3. The 'Letter_detection' function (not provided in the code) is responsible for recognizing individual letters from binary images. Make sure to implement or obtain this function for accurate character recognition.

