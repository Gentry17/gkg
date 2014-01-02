#!/usr/bin/perl

#subset.pl
#version:			2.0
#date:				20140101

#Reads GKG daily files in a given range and subsets them according to theme
#Writes to STDOUT for piping (to getlocations.pl for instance)
#Usage: subset.pl DIR THEME START END > OUTFILE
#Command line parameters:
#DIR = Subdirectory containing the source files (assumed to be in the current directory)
#THEME = GKG theme 
#START,END = Date range in format YYYYMMDD
#OUTFILE = Output file 

use DateTime;

$SDIR = @ARGV[0];
$THEME = @ARGV[1];
$START = @ARGV[2];
$END = @ARGV[3];


#opendir SOURCE, $SDIR or die "Directory not found!";

$day=DateTime->new ({ year=>substr($START,0,4), month=>substr($START,4,2), day=>substr($START,6,2)});

while($day->ymd('') le $END) {

		$date1 = $day->ymd(''); print"$date1\n";
		open(FILE, "./$SDIR/$date1.gkg.csv");
    	$lineid = 0;
  		while(<FILE>) {
  			if ($lineid > 0) {
  				($date, $numarts, $countevents, $themes, $locations, $persons, $organizations, $tonepack, $cameoevents, $sources, $sourceurls) = split/\t/, $_;
				if (index($themes, $THEME) > -1) {  
					print ; 
					}
				}
			$lineid++;		
		}
		close(FILE);   
		$day->add(days=>1); 
		
}

