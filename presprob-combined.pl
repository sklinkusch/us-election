#!/usr/bin/perl -w
# Preface
use strict;
use warnings;
use diagnostics;
use Algorithm::Combinatorics qw/variations_with_repetition/;
use List::Util qw(first);
use FindBin;
use lib $FindBin::RealBin;
use Elections qw(get_statevals get_parstates check_par check_states get_openstates get_closedstates get_safeval get_swingperm commify sort_states delete_mainenebraska build_mat result_mat get_statedesc get_head build_permas modify_maine modify_nebraska print_info get_nome modify_results delete_doubles get_percent closed_simple build_matpc commify_float);

if ($#ARGV < 1){
	print "Usage: presprob-combined.pl <data file> <percent file>\n";
	print "data file contains all states/districts with D/R/X notifier\n";
	print "percent file contains dem/rep probability for all states/districts\n";
	exit;
}

my $datfile = $ARGV[0];
my $percfile = $ARGV[1];

# get the states and the respective number of electors
my %statevals = get_statevals();

# get the percentages from percent file
my %dsperc;
my %rsperc;
get_percent($percfile,\%dsperc,\%rsperc);

# put the hash keys and values into two arrays (sorted)
my @allstates = sort { $statevals{$b} <=> $statevals{$a} || $a cmp $b } keys %statevals;
my @valstates = @statevals{@allstates};
my @demstates = get_parstates($datfile,'D');
my @repstates = get_parstates($datfile,'R');
my ($dmesum,$dnesum,$dme,$dmea,$dmeb,$dmex,$dne,$dnea,$dneb,$dnec) = check_par(\@demstates, \@allstates);
my ($rmesum,$rnesum,$rme,$rmea,$rmeb,$rmex,$rne,$rnea,$rneb,$rnec) = check_par(\@repstates, \@allstates);
check_states(@demstates,@repstates);
my $ifme;
my $ifmea;
my $ifmeb;
my $ifne;
my $ifnea;
my $ifneb;
my $ifnec;
my $mesum;
my $nesum;
my @closedstates = get_closedstates(\@demstates,\@repstates,\$ifme,\$ifmea,\$ifmeb,\$ifne,\$ifnea,\$ifneb,\$ifnec,\$mesum,\$nesum);
my @openvalx;
my @swingsts;
get_openstates(\%statevals,\@allstates,\@closedstates,\@swingsts,\@openvalx);
my @openvals = sort { $b <=> $a } @openvalx;
my $perms = $#swingsts + 1;
my $demsafe = get_safeval(\%statevals,\@demstates);
my $repsafe = get_safeval(\%statevals,\@repstates);
my $nrop = 1;
my $swingnum = get_swingperm(\%statevals,\@swingsts,\$nrop);
my $total = $demsafe + $repsafe + $swingnum;
my $needed = ($total / 2) + 1;
my $demgap = $needed - $demsafe;
my $repgap = $needed - $repsafe;
my $nropx = commify($nrop);
my $demno = $#demstates + 1;
my $repno = $#repstates + 1;
my $swino = $#swingsts + 1;
my $demst = sort_states(@demstates);
my $repst = sort_states(@repstates);
my $swist = sort_states(@swingsts);
my $ifdme = $demst =~ /ME/ ? 1 : 0;
my $ifrme = $repst =~ /ME/ ? 1 : 0;

# Print general information
print "Democratic states ($demno): $demst\n" if $demno > 0;
print "Republican states ($repno): $repst\n" if $repno > 0;
print "Open states       ($swino): $swist\n" if $swino > 0;
printf "Democratic votes:   %3u\n", $demsafe if $demno > 0;
printf "Republican votes:   %3u\n", $repsafe if $repno > 0;
printf "Open votes:         %3u\n", $swingnum if $swino > 0;
printf "Total votes:        %3u\n", $total;
printf "Needed for victory: %3u\n", $needed;
printf("Number of permutations:         %26s\n",$nropx);