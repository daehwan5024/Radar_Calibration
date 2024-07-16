function[num_radar, posAbsolute, distAbsolute, distMeasured] = RadarDataGenerator()
% Makes random data for testing

  % Generate Datas
  num_radar = 8;
  posAbsolute = rand(3, num_radar);
  posAbsolute(1:2, :) = posAbsolute(1:2, :) * 20 - 10;
  posAbsolute(3,1:end-3) = posAbsolute(3,1:end-3) + 2.5;

  distAbsolute = pairwiseDist(posAbsolute);
  distMeasured = addNoise(distAbsolute);
end