# Radar Auto Calibration

## How to use

run `GradientDOP.mlx` or `GradientTriangleSize.mlx`\
This will generate random data and run calibration process

Calibration can also be done by using `getCalibratedPDOP.m` or `getCalibratedTrianlgeSize` function

## Scripts

`compare_DOP.m` :

`create_Data.m`\
Creates data containing radar position, noise and the calibrated result\
Uses `parfor` for better performance `parallel computing toolbox` needed

`create_Data2.m`\
Identical to `create_Data.m` expect that it uses `getRadarData2.m` instead of `getRadarData.m`

`find_file.m`\
Find the file that holds a specific value for a variable

`good_pos.m`\
Used to find which position has low error

`img_filter.m`\
Filter dataset with imaginary calibration value

`plotter.m`\
Plots Data

`GradientDOP.mlx`\
Matlab Live Code file for calibration based on PDOP

`GradientTriangleSize.mlx`\
Matlab Live Code file for calibration based on triangle size

`untitled.m` `untitled2.m`\
Files for testing. Has nothing to do with the project

## Functions

`getBetter.m`\
returns position that better fits the given data

`getCalibratePDOP.m`\
Calibration based on PDOP. Uses gradient descent for better result

`getCalibrateTriangleSize.m`\
Calibration based on triangle size. Uses gradient descent for better result

`getInsertOrder.m`\
returns all possible insertion orders based on PDOP. Value is infinity if impossible

`getNoiseAdded.m`\
return value with noise added to real value

`getPairwiseDist.m`\
return distance of all radar pairs

`getPDOPList.m`\
returns list of all possible pairs for PDOP

`getRadarData.m`\
returns random radar positions and noise added to distance

`getRadarData2.m`\
same as `getRadarData.m` with different constraint for random position

`getTransform.m`\
return 4x4 transform matrix to match the first 3 points to the xy-plane

`getTriangle.m`\
returns 3 points based on distance

`getTriangleList.m`\
returns list of all possible triangles sorted by size

## .py Files
Mainly for changing or modifying stored data values
