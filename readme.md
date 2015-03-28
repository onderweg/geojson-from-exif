#GeoJSON from Exif

Takes a path to a directory containing JPEG images and outputs a GeoJSON structure with Exif GPS coordinates from those images.

##Usage

Use from OS X command line:

	$ geojson-from-exif [path_to_directoy]
	
The directory path is optional. If none given, current directory is used.


##Notes

You can use [GeoJSONLint][geojsonlint] to test the output.

This is a quick and dirty experiment with the new (at the time of writing) Swift language. I make no guarantees or warranties as to its accuracy, stability or compatibility.

##Similar

* [exif-to-geojson (Github)](https://github.com/hallahan/exif-to-geojson)

[geojsonlint]: http://geojsonlint.com/

##License

Copyright G. Stevens 2014, all rights reserved.

You are permitted to use, fork, modify and distribute this work.

Under the following condition:

If you wish to use the code in this repository in a project of your own,
in any way that could be considered `derivative work,' then you must show attribution.
