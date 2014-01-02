#!/usr/bin/perl

#getlocations.pl
#version:			1.0
#date:				20140101

#Extracts all locations from a GKG file (possibly subset by rows by subset.pl)
#Outputs one location per line, with NUMART as weight (i.e. number of articles from original files)
#Usage: subset.pl FILE > OUTFILE
#Command line parameters:
#FILE =  source file
#OUTFILE = Output file 


$SFILE = @ARGV[0];

open(FILE, "$SFILE");
print "date\tgeotype\tfullname\tcountrycode\tlat\tlong\tnumarts\n";
while(<FILE>) {
	($date, $numarts, $countevents, $themes, $locations, $persons, $organizations, $tonepack, $cameoevents, $sources, $sourceurls) = split/\t/, $_;
	@points = split/;/,$locations;
	foreach $point(@points) {
		($geotype,$fullname,$countrycode,$admin1code,$lat,$long,$fetid) = split/#/, $point;
		print "$date\t$geotype\t$fullname\t$countrycode\t$lat\t$long\t$numarts\n";
		}
}
close(FILE);
