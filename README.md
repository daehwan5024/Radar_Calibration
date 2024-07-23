# Radar Auto Calibration

## How it works

When 3 points and distance from 3 points to one unkown point are given, 3d position of the unkown point can be calculated. \
Using this idea, when distance between radars are given, it is possible to calculate relative positions of the radars.

The distance are measured data, which will contain errors. To minimize the error of positions, radar position is calculated with orders to minimize PDOP(position dilution of precision).\
After 1st position is calculated, gradient descent is used to minimize the difference between measured distance and calculated distance(using radar position)

Error of position is measured as the average of the distance between real radar position and calculated radar position.\
In order to match the real data and the calibrated data, rotation and translation is used to match the 1st point to the origin, 2nd point to the x-axis and 3rd point to the xy-plane.\
1st, 2nd, and 3rd point are selected that they minimize the error with given real and calibrated positions.

## How to use

run `GradientDOP.mlx` or `GradientTriangleSize.mlx`\
This will generate random data and run calibration process

Calibration can also be done by using `getCalibratedPDOP.m` or `getCalibratedTrianlgeSize` function

## Data Files

Data Files are stored inside `Stored Data` folder.\
Each folder will have subfolders of format `[0-9]_[0-9]_[0-9]`.\
The First number is the number of tags at the bottom($\le 4$)\
Second number is the number of radars on top($\le 6$)\
Last number is number of walls that the radars can be attached to($\le 4$)

Each files in the subfolders are `.mat` files. Each file contains 4 matrices.\
The 4 matrices are `errors`,`distMeasured`, `posCalibrated`, and `posAbsolute`

`posAbsolute`: $3\times n$ matrix that holds absolute position of tags and radars.\
Each column is a value that corresponds to `x,y,z` value of the position.\
Tags positions are placed at the front

`distMeasured`: $5\times n \times n$ matrix that holds measured distance.\
Errors in measured distance are normal with $3\sigma = 10cm$. Distance between tags have 0 error since they aren't a meausred value.\
5 meaurements are stored, and each is represented as a $n\times n$ matrix

`posCalibrated`: $5\times 3 \times n$ matrix that holds calibrated position.\
Each $3\times n$ matrix holds the calibrated position of the corresponding `distMeasured`.\
Values may be imaginary

`errors`: $4\times 5$ matrix that holds error between `posAbsolute` and `posCalibrated`\
Each column cotains mean error, and 3 points that are used to rotate and translate the position

## Scripts

`create_Data.m`\
Creates data containing radar position, noise and the calibrated result\
Uses `parfor` for better performance(`parallel computing toolbox` needed)

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

`variation.m`\
changes number of radar on top, tag at bottom, number of walls radars are attached.
Check the error as the variables are changed

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

`getDifference.m`\
returns difference of two position matrices. uses rotaion and translation to match matrices

`getInsertOrder.m`\
returns all possible insertion orders based on PDOP. Value is infinity if impossible

`getNoiseAdded.m`\
return value with noise added to real value

`getNoiseAdded2.m`\
return value with noise added to real value. Does not add noise to distance between bottom tags.

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

## Possible errors

 Calibrated position using `getCalibratedPDOP.m` may result in imaginary values.
 This is because measured distance contain errors.
 When imaginary values are returned, we may use different orders for calibration, or measure the distance again.

 When calibrating `Warning: Matrix is singular to working precision` may appear on `getPDOPList.m`.\
 This occurs because when 4 points are on 1 plane, PDOP value will diverge.\
 This warning is not an error, and calibration process will run fine with this warning