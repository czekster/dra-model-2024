#!/usr/bin/perl

# Author: Ricardo M. Czekster (rczekster at gmail com)

# Created:  01/07/2024
# Modified: 14/11/2024

# This Perl script will take a simulation output (as generated by Arena Simulation Suite),
# process it, and extract meaningful performance indices, which will be outputted to a file
# (passed by parameter in the command line) with termination .txt

# Requirements: Perl have to be installed in the machine and executables on PATH environment
# Usage: C:\perl process.pl main-model-v7.out  (it will create a file called main-model-v7.out.txt)

use strict;
use warnings;

if (@ARGV != 1) {
    print "usage: process.pl FILE\n";
    exit;
}

my $name = $ARGV[0];
my $file = "C:\\tmp\\analysis\\$name"; # FIX your file path !

open(INFILE, "<$file") or die("cannot open hash file named $file\n");
my(@lines) = <INFILE>;
close(INFILE);

my %data=();
my $SAMPLES=0;

open(OUTFILE, ">$name.txt") or die("cannot open $name.txt\n");

foreach my $line (@lines) {
   $line =~ s/\n//g;
   next if (length($line) == 0);
   if ($line =~ /E\_1ST\.VATime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'1st-VATime'} .= $2.";";
   }
   if ($line =~ /E\_1ST\.WaitTime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'1st-WaitTime'} .= $2.";"; 
   }
   if ($line =~ /E\_1ST\.TotalTime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'1st-TotalTime'} .= $2.";"; 
   }
   if ($line =~ /E\_2ND\.VATime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'2nd-VATime'} .= $2.";"; 
   }
   if ($line =~ /E\_2ND\.WaitTime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'2nd-WaitTime'} .= $2.";"; 
   }
   if ($line =~ /E\_2ND\.TotalTime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'2nd-TotalTime'} .= $2.";"; 
   }
   if ($line =~ /E\_3RD\.VATime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'3rd-VATime'} .= $2.";"; 
   }
   if ($line =~ /E\_3RD\.WaitTime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'3rd-WaitTime'} .= $2.";"; 
   }
   if ($line =~ /E\_3RD\.TotalTime(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'3rd-TotalTime'} .= $2.";"; 
   }
   #if ($line =~ /Consultation\.Queue\.WaitingTime(\s*)(([0-9]*[.])?[0-9]+)/) {
   #   $data{'ConsultationQueueWaitingTime'} .= $2.";"; 
   #}
   if ($line =~ /Automated_script\.Utilization(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'Automated_scriptUtilization'} .= $2.";"; 
   }
   if ($line =~ /MD\.Utilization(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'MDUtilization'} .= $2.";"; 
   }
   if ($line =~ /RTEAM\.Utilization(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'RTEAMUtilization'} .= $2.";"; 
   }
   if ($line =~ /NURSE\.Utilization(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'NURSEUtilization'} .= $2.";";
   }
   if ($line =~ /TTEAM\.Utilization(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'TTEAMUtilization'} .= $2.";";
   }
   if ($line =~ /STEAM\.Utilization(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'STEAMUtilization'} .= $2.";";
   }
   if ($line =~ /Process EQUIP by STEAM\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcEQUIP-STEAMQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process BED by nurse\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcBED-NURSEQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process DIAGNOSTIC by IT\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcDIAG-ITQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process MIoT by MD\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcMIOT-MDQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process ICT by IT\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcICT-ITQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process suspicions\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'Proc-suspicious-MDQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Mitigate and Respond\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'Proc-suspicious-MDQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Automated Data Processing\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcAUTOMATEDQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process WEARABLE by nurse\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProcWEAR-NURSEQueueNumberInQueue'} .= $2.";"; 
   }
   if ($line =~ /Process HOSPITAL by IT\.Queue\.NumberInQueue(\s*)(([0-9]*[.])?[0-9]+)/) {
      $data{'ProHOSP-ITQueueNumberInQueue'} .= $2.";"; 
   }
}
my @arr=();
my $c=0;
foreach my $key (sort keys %data) {
   print OUTFILE $key.";";
   my (@values) = split(";", $data{$key});
   $arr[$c++] = \@values;
   $SAMPLES = @values;
}
print OUTFILE "\n";

for (my $i=0; $i<$SAMPLES; $i++) {
   for (my $j=0; $j<@arr; $j++) {
      my $newvalue = $arr[$j][$i];
      #$newvalue =~ s/\./\,/g;
      print OUTFILE $newvalue.";";
   }
   print OUTFILE "\n";
}

close(OUTFILE);

print "done.\n";
