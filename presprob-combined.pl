#!/usr/bin/perl -w
# Preface
use strict;
use warnings;
use diagnostics;
use Algorithm::Combinatorics qw/variations_with_repetition/;
use List::Util qw(first);
use FindBin;
use lib $FindBin::RealBin;
use Elections qw(get_statevals get_parstates check_par check_states get_openstates get_closedstates get_safeval get_swingperm commify sort_states delete_mainenebraska build_mat result_mat get_statedesc get_head build_permas modify_maine modify_nebraska print_info get_nome modify_results delete_doubles get_percent closed_simple build_matpc commify_float get_mustwin);

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
printf("Number of permutations:                                                       %26s\n",$nropx);

# Calculate and print probabilities (without percents)
my @swinr = delete_mainenebraska(@swingsts,@openvals);
my $ifmaineclosed;
my $ifnebraskaclosed;
my @messum = ($mesum, $dmesum, $rmesum);
my @nessum = ($nesum, $dnesum, $rnesum);
my @dempuremat = build_mat($#swinr+1,538,$demsafe,\@messum,\@nessum,\@openvals);
my @reppuremat = build_mat($#swinr+1,538,$repsafe,\@messum,\@nessum,\@openvals);
my @respuremat = result_mat(\@dempuremat,$#swinr);
my $szenariosPure = $respuremat[3];
my $nonsensPure = $nrop - $szenariosPure;
my $nonsensxPure = commify($nonsensPure);
my $szenariosxPure = commify($szenariosPure);
printf("Non-sensible permutations:                                                    %26s\n", $nonsensxPure);

# Calculate and print probabilities (with percents)
my @demPercentMat = build_matpc($swino,$total,$demsafe,\@openvals, \@swingsts,\%dsperc);
my @repPercentMat = build_matpc($swino,$total,$repsafe,\@openvals, \@swingsts,\%rsperc);
my @resPercentMat = result_mat(\@demPercentMat,$#swingsts);
my $szenariosPercent = $resPercentMat[3];

my $szenarsPercent = sprintf("% 26.4f",$szenariosPercent);
my $szenariosxPercent = commify_float($szenarsPercent);

# printf("Non-sensible permutations:     %26s\n", $nonsensx);
printf("Szenarios gesamt:              %32s               %26s\n", $szenariosxPercent, $szenariosxPure);

# Calculating tie probability
my $summtPercent = sprintf("% 26.4f",$resPercentMat[1]);
my $summtxPercent = commify_float($summtPercent);
my $tieprobPercent = 100 * $summtPercent / $szenariosPercent;
my $summtPure = $respuremat[1];
my $summtxPure = commify($summtPure);
my $tieprobPure = 100 * $summtPure / $szenariosPure;

if ($summtPercent != 0 or $summtPure != 0){
	printf("Tie probability:   %8.4f %%  %32s   %8.4f %%  %26s\n", $tieprobPercent, $summtxPercent, $tieprobPure, $summtxPure);
}

# Calculating Dem probability
my $summdPercent = sprintf("% 26.4f",$resPercentMat[2]);
my $summdxPercent = commify_float($summdPercent);
my $demprobPercent = 100 * $summdPercent / $szenariosPercent;
my $summdPure = $respuremat[2];
my $summdxPure = commify($summdPure);
my $demprobPure = 100 * $summdPure / $szenariosPure;
if ($summdPercent != 0 or $summdPure != 0){
	printf("Dem. probability:  %8.4f %%  %32s   %8.4f %%  %26s\n", $demprobPercent, $summdxPercent, $demprobPure, $summdxPure);
}

# Calculating Rep probability
my $summrPercent = sprintf("% 26.4f",$resPercentMat[0]);
my $summrxPercent = commify_float($summrPercent);
my $repprobPercent = 100 * $summrPercent / $szenariosPercent;
my $summrPure = $respuremat[0];
my $summrxPure = commify($summrPure);
my $repprobPure = 100 * $summrPure / $szenariosPure;
if ($summrPercent != 0 or $summrPure != 0){
	printf("Rep. probability:  %8.4f %%  %32s   %8.4f %%  %26s\n", $repprobPercent, $summrxPercent, $repprobPure, $summrxPure);
}

if($swino <= 15 and $swino > 0){

	# Calculate and print corrected probabilities (and all the variations)
	my $iter = variations_with_repetition([qw/D R/], $perms);
	my @statedesc = get_statedesc(@swingsts);
	my $head = get_head($swino,\@statedesc,\@openvals);
	my @permas;
	my @safe = ($demsafe, $repsafe, $needed);
	my @winners;
	my $count = 0;

	while ( my $p = $iter->next) {
		build_permas('V',$count,$p,$swino,\%statevals,\@swingsts,\@safe,\@permas,\@winners);
		$count++;
	}
	my @permbs;
	my @winna;
	modify_maine($nrop, $swino, $mesum, $dmesum, $rmesum, \@swingsts, \@permas, \@permbs, \@winners, \@winna);
	my $dummyvar = ($#permbs + 1)/$swino;
	my @permcs;
	my @winnb;
	modify_nebraska($dummyvar,$swino,$nesum,$dnesum,$rnesum,\@swingsts,\@permbs,\@permcs,\@winna,\@winnb);
	$dummyvar = ($#permcs + 1)/$swino;

	my ($nome, $nomex) = get_nome(@swingsts);
	my @linea = modify_results($dummyvar,$swino,$nome,$nomex,$demsafe,$repsafe,$needed,\@permcs,\%statevals,\@swingsts);
	delete_doubles($dummyvar,\@linea);

	if($demsafe < $needed and $repsafe < $needed){
		my @mustwin = get_mustwin(\@linea,\@statedesc);
		print join('',@mustwin) if ($#mustwin > -1);

	}
} else {
	my @rneeded;
	my @dneeded;
	foreach my $noopen (0..$#swingsts) {
		if($statevals{$swingsts[$noopen]} >= $demgap) {
			push(@rneeded, $swingsts[$noopen]);
		}
		if($statevals{$swingsts[$noopen]} >= $repgap) {
			push(@dneeded, $swingsts[$noopen]);
		}
	}
	my $rneedstring = sprintf("Needed for Victory (R): " . "%-3s" x @rneeded . "\n", @rneeded) if ($#rneeded >= 0);
	my $dneedstring = sprintf("Needed for Victory (D): " . "%-3s" x @dneeded . "\n", @dneeded) if ($#dneeded >= 0);
	print $rneedstring if ($#rneeded >= 0);
	print $dneedstring if ($#dneeded >= 0);
}
