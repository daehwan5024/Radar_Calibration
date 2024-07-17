# Radar Auto Calibration

## How to use

run `RadarDataGenerator.m` This wil create `radarData.mat` file.

After `radarData.m` file is created, run `GradientDOP.mlx` or `GradientTriangleSize.mlx`\
(Matlab editor is needed to run `.mlx` files)

## Files

`RadarDataGenerator.m` :
Generates random data and store previous data at prevData folder

`plotter.m` :
Plots radar position based on the calculated result

`GradientDOP.mlx` :
Calculate position using PDOP and gradient descent

`GradientTriangleSize.mlx` :
Calculate position using TriangleSize and gradient descent

## Functions

`coordinatTransform.m` :
returns 4x4 Matrix to transform coordiante

`getDOPList.m` :
returns List of DOP for all possible combination

`getTriangle.m` :
returns three points of a triangle cooresponding to the three input distance

`getTriangleList.m` :
returns List of all triangles for all possible combination

`insertOrder.m` :
returns List of all possible orders of radar calibration

`pairwiseDist.m` :
return NxN matrix of distance between radars, when position is given

`selectBetter.m` :
returns the point that better fits the current data

`trilateration.m`:
returns position of target using 3 points and distance from each point

`addNoise.m` :
add random noise to given pairwise Distance
