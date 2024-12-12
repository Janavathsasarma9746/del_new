# load terra package
library(terra)

# set working directory(input files)
setwd("D:/VICT_R_Terra/01_data")

# location to save outputs
resample.path = file.path("D:/VICT_R_Terra/Resolution_1km/preprocess")

#extent of ethiopia same as ethiopia_aoi.tif
tile <- rast(res= 0.00924, xmin=32.9899149155, xmax=47.9771949155, ymin=3.403333435, ymax=14.879413435,crs="+proj=longlat +datum=WGS84")

# call the files ends with the .tif extension in the working directory
dataPath <-list.files(pattern = ".tif$", full.names = F)

# loop call the files 1 by 1 to resample it
#for (i in 1:length(dataPath))
for (i in 1:8)  
{
  # call the files to resample
  dataRaw <- rast(dataPath[i])
  
  #resample the file called(dataPath[i])
  dataProj <- project(dataRaw,tile,method="near")
  
  # mask raster
  m <- rast("D:/VICT_R_Terra/Resolution_1km/ethiopia_aoi_1km.tif")
  mr2 <- mask(dataProj, m)
  
  #save the output
  writeRaster(mr2,file.path( resample.path, dataPath[i]),overwrite=TRUE,datatype=datatype(dataRaw))
  
  # remove the files from the workspace
  rm(dataRaw)
  rm(dataProj)
}
