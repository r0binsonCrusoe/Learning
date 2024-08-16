# Module 02 Lab Assignment

## Table of contents

<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Module 02 Lab Assignment](#module-02-lab-assignment)
	- [Table of contents](#table-of-contents)
	- [Overview](#overview)
	- [Data files](#data-files)
		- [Project setup](#project-setup)
		- [Connecting dataset](#connecting-dataset)
	- [Required specifications of the deliverable](#required-specifications-of-the-deliverable)
		- [Submission](#submission)
		- [Challenge](#challenge)
	- [Example for Colorado](#example-for-colorado)
	- [Suggestions and Tips](#suggestions-and-tips)

<!-- /TOC -->

## Overview

You've been contracted by HydroTime to collect and map data for streams by state. They are interested in visualizing the stream networks in the contiguous states. Your contract specifies that you should pick your home state to map, and a bonus is given if you provide summary statistics for streams in your state.

We will collect and analyze the data in this module and create the map layout in the following module. Part of the challenge of a mapping project is managing data. This lab has a big dataset that we need to prune down before we start mapping.

The requirements of the map are listed below. You will submit all deliverables as files in this GitHub repository. All the tasks required to fulfill this assignment are documented within Module 02.

## Data files

The following data were downloaded from [The National Map Small-Scale Collection](https://nationalmap.gov/small_scale/atlasftp.html). The layers have been combined into a single SpatiaLite database.

### Project setup
1. If you haven't already, create a folder called "downloaded-data" in a directory alongside this repository.
2. Download the SpatiaLite database:
[https://www.dropbox.com/s/k1toqh37ugqos3o/US_SmallScale_Data_NAD83.zip?dl=0](https://www.dropbox.com/s/k1toqh37ugqos3o/US_SmallScale_Data_NAD83.zip?dl=0)
3. Extract the .zip file to the *downloaded-data*. This is a large file and we don't want it in our repository. _*.zip_ and _*.sqlite_ will be ignored by Git with the settings in the *.gitignore* file. **Please don't change the *.gitignore* file or rename the *US_SmallScale_Data_NAD83.sqlite* file**! You could create an annoying error in GitHub.
4. If you see a .zip or .sqlite in your GitHub Desktop *Changes* tab, don't commit it! Instead remove the file from your repo and/or check that the _*.zip_ and _*.sqlite_ are listed in the *.gitignore* file.

![Example of your directory setup for this course](graphics/q00-co-example.png)   
Figure 01: Example of your directory setup for this course. Keep your downloaded-data outside of your repository.

### Connecting dataset

1. Open QGIS's **Browser Panel** and right-click **SpatiaLite > new connection**. Navigate to the .sqlite file and connect the database.
2. Add layers to your Map canvas
3. Import these layers to your PostGIS database *public* schema
4. Delete the .zip and .sqlite files.

That's how we get data into our GIS database.


## Required specifications of the deliverable

1) The client has also requested a SQL file that extracts streams, state polygon, urban areas, and waterbodies for **one state**. The SQL file must fulfill the following requirements:

* Pick any state covered by the data and create four layers of data that cover this state.
* Use the starter template in *lab-02/data.sql* to write your SQL statements that extracts the data. Include a statement for each layer.
* For the stream layer, sort the output by the stream order, with the largest streams listed at the top. Show how you would sort the data in the *data.sql* file.

2) The client has also requested a copy of these layers as a custom GeoJSON format. The GeoJSON must fulfill the following requirement:

* Export your layers as GeoJSON layers (*.geojson*) and store them in the folder located at *lab-02/geojsons/*. You should right-click each layer and **Save as...** to a GeoJSON.
* Coordinate Reference System must be WGS84.
* Coordinate precision of no more than four.
* Attribute requirements per layer (exclude all attributes except those listed):
  * Stream layer: name, length_mi, and stream order
  * Urban areas layer: name, gis_acres
  * Waterbodies layer: name, feature, area_sq_miles
  * State layer: name
* Add the *.geojson* file to the folder located at *lab-02/geojsons/*
* Create a "README.md" file in the *lab-02/geojsons/* folder that describes your four GeoJSON layers, e.g., what state did you select, what are the long names of the GeoJSONs (if you used abbreviations), and what is the source of the data?
* **No GeoJSON can be over 20 MB**.

Commit your changes often and add detailed comments your SQL file. Push the changes before you submit your repository link.

### Submission

Paste URL link within the Canvas to this repo, e.g., *newmapsplus/map672-module-02-<username>*.

### Challenge

Add SQL statements and comments to the *lab-02/data.sql* file that finds:
* the largest waterbody in your state and provide it's name and
* the longest stream in your state and provide it's name.


## Example for Colorado
![Example output from lab 01](graphics/q01-co-example.png)   
Figure 02: **Save as...** to a new GeoJSON for each layer

## Suggestions and Tips

If you find that your map is rendering too slowly after you queried your layers (especially the streams layer), you have a couple options:

* Disable rendering via the **Render** option in Map Canvas task bar.
* **Filter...** the data to a smaller dataset before import into the PostGIS database.
* Use a `create table new_table_name as` before adding the layer to Map Canvas.
* Note, that the SpatiaLite database can use SQL, too (on Linux and Windows OS).

If you use the `limit` clause you can speed-up simple queries:

```
select
  *
from
    nhd_streams
limit
  100
```
