#!/usr/bin/perl -w
# Added by HI to add robots.txt to DocumentRoot if it has not already been done (eg a previous installation)
# This script self-destructs
use strict;
# Read the current drupal robots.txt into memory
# Get the current drupal robots.txt version number
# If there is an existing robots.txt - read it into memory
# Does it contain the present robots.txt - if so do nothing
# Open robots.txt for writing
# Write exiting and new to robots.txt
# Unlink this program

# Read the current drupal robots.txt into memory
open NEW, "< /websites/123reg/LinuxPackage22/ha/rr/y_/harry-burgess.co.uk/public_html/robots.txt" or die;
my @new = <NEW>;
close NEW;

# Get the current drupal robots.txt version number
my $new_version = '';
my $line = '';
foreach $line (@new) {
    chomp $line;
    next unless $line =~ m/# Drupal version/ ;
    $new_version = $line;
}
if (! $new_version ) {
    print STDERR "Robots.txt does not have a version number - exiting\n";
    exit 1;
}

# If there is an existing robots.txt in the DocumentRoot directory - read it into memory
my @old = ();
my $fchk = open OLD, "</websites/123reg/LinuxPackage22/ha/rr/y_/harry-burgess.co.uk/public_html/robots.txt" ;
if ($fchk) {
    @old = <OLD>;
    close OLD;
    foreach $line (@old) {
         chomp $line;
         next unless $line =~ m/$new_version/ ;
         # Does it contain the present robots.txt - if so do nothing
         exit 0;
    }
}

open NEW, ">/websites/123reg/LinuxPackage22/ha/rr/y_/harry-burgess.co.uk/public_html/robots.txt" or die ;
foreach $line (@old,  @new) {
    print NEW "$line\n";
}
close NEW;


unlink $0;
