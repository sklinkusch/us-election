#!/usr/bin/perl -w
# Preface
use strict;
use warnings;
use diagnostics;
use Algorithm::Combinatorics qw/variations_with_repetition/;
use List::Util qw(first);
use Cwd 'abs_path';
use FindBin;
use lib $FindBin::RealBin;
use Elections qw(get_statevals get_parstates check_par check_states get_openstates get_closedstates get_safeval get_swingperm commify sort_states delete_mainenebraska build_mat result_mat get_statedesc get_head build_permas modify_maine modify_nebraska print_info get_nome modify_results delete_doubles get_percent closed_simple build_matpc commify_float get_mustwin);

if ($#ARGV < 1){
	print "Usage: presprob-combined.pl <data file> <percent file>\n";
	print "data file contains all states/districts with D/R/X notifier\n";
	print "percent file contains dem/rep probability for all states/districts\n";
	exit;
}

my $datfile = join('',$ARGV[0]);
my $percfile = join('',$ARGV[1]);
my $fulldat = abs_path($datfile);
my $fullperc = abs_path($percfile);

# get the states and the respective number of electors
my %statevals = get_statevals();

# get the percentages from percent file
my %dsperc;
my %rsperc;
get_percent($fullperc,\%dsperc,\%rsperc);

# get borders
my $safeborder = 98.0;
my $likelyborder = 90.0;
my $leanborder = 70.0;
my $tiltborder = 55.0;

# put the hash keys and values into two arrays (sorted)
my @allstates = sort { $statevals{$b} <=> $statevals{$a} || $a cmp $b } keys %statevals;
my @valstates = @statevals{@allstates};
my @demstates = get_parstates($fulldat,'D');
my @repstates = get_parstates($fulldat,'R');
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
my @swingstsD = grep { $dsperc{$_} >= $tiltborder } @swingsts;
my @swingstsDS = grep { $dsperc{$_} >= $safeborder } @swingstsD;
my @swingstsDLk = grep { $dsperc{$_} >= $likelyborder } @swingstsD;
my @swingstsDLn = grep { $dsperc{$_} >= $leanborder } @swingstsD;
my @demsafestates = @swingstsDS;
my @demlikelystates = grep { $dsperc{$_} < $safeborder } @swingstsDLk;
my @demleanstates = grep { $dsperc{$_} < $likelyborder } @swingstsDLn;
my @demtiltstates = grep { $dsperc{$_} < $leanborder } @swingstsD;
my @swingstsR = grep { $rsperc{$_} >= $tiltborder } @swingsts;
my @swingstsRS = grep { $rsperc{$_} >= $safeborder } @swingstsR;
my @swingstsRLk = grep { $rsperc{$_} >= $likelyborder } @swingstsR;
my @swingstsRLn = grep { $rsperc{$_} >= $leanborder } @swingstsR;
my @repsafestates = @swingstsRS;
my @replikelystates = grep { $rsperc{$_} < $safeborder } @swingstsRLk;
my @repleanstates = grep { $rsperc{$_} < $likelyborder } @swingstsRLn;
my @reptiltstates = grep { $rsperc{$_} < $leanborder } @swingstsR;
my @swingstsT = grep { abs($dsperc{$_} - $rsperc{$_}) < 10 } @swingsts;
my $null = 1;
my $swingnumD = get_swingperm(\%statevals, \@swingstsD, \$null);
my $swingnumDS = get_swingperm(\%statevals, \@swingstsDS, \$null);
my $swingnumDLk = get_swingperm(\%statevals, \@swingstsDLk, \$null);
my $swingnumDLn = get_swingperm(\%statevals, \@swingstsDLn, \$null);
my $swingnumR = get_swingperm(\%statevals, \@swingstsR, \$null);
my $swingnumRS = get_swingperm(\%statevals, \@swingstsRS, \$null);
my $swingnumRLk = get_swingperm(\%statevals, \@swingstsRLk, \$null);
my $swingnumRLn = get_swingperm(\%statevals, \@swingstsRLn, \$null);
my $swingnumT = get_swingperm(\%statevals, \@swingstsT, \$null);
my $swingnumTLn = $swingnum - ($swingnumDLn + $swingnumRLn);
my $swingnumTLk = $swingnum - ($swingnumDLk + $swingnumRLk);
my $swingnumTS = $swingnum - ($swingnumDS + $swingnumRS);
my $total = $demsafe + $repsafe + $swingnum;
my $needed = ($total / 2) + 1;
my $demgap = $needed - $demsafe;
my $repgap = $needed - $repsafe;
my $nropx = commify($nrop);
my $demno = $#demstates + 1;
my $repno = $#repstates + 1;
my $swino = $#swingsts + 1;
my $swinoD = $#swingstsD + 1;
my $swinoR = $#swingstsR + 1;
my $swinoT = $#swingstsT + 1;
my $demst = sort_states(@demstates);
my $repst = sort_states(@repstates);
my $swist = sort_states(@swingsts);
my $swistD = sort_states(@swingstsD);
my $swistDS = sort_states(@demsafestates);
my $swistDLk = sort_states(@demlikelystates);
my $swistDLn = sort_states(@demleanstates);
my $swistDTt = sort_states(@demtiltstates);
my $swistR = sort_states(@swingstsR);
my $swistRS = sort_states(@repsafestates);
my $swistRLk = sort_states(@replikelystates);
my $swistRLn = sort_states(@repleanstates);
my $swistRTt = sort_states(@reptiltstates);
my $swistT = sort_states(@swingstsT);
my $ifdme = $demst =~ /ME/ ? 1 : 0;
my $ifrme = $repst =~ /ME/ ? 1 : 0;

# Print general information
printf "Democratic states (%2u): %s\n", $demno, $demst if $demno > 0;
printf "Republican states (%2u): %s\n", $repno, $repst if $repno > 0;
printf "Open states       (%2u): %s\n", $swino, $swist if $swino > 0;
printf "Open dem. states  (%2u): %s\n", $swinoD, $swistD if $swinoD > 0;
printf "Open rep. states  (%2u): %s\n", $swinoR, $swistR if $swinoR > 0;
printf "Open toss-up states (%2u): %s\n", $swinoT, $swistT if $swinoT > 0;
printf "Dem. safe states  (%2u): %s\n", $#demsafestates+1, $swistDS if $#demsafestates >= 0;
printf "Dem. likely states(%2u): %s\n", $#demlikelystates+1, $swistDLk if $#demlikelystates >= 0;
printf "Dem. lean states  (%2u): %s\n", $#demleanstates+1, $swistDLn if $#demleanstates >= 0;
printf "Dem. tilt states  (%2u): %s\n", $#demtiltstates+1, $swistDTt if $#demtiltstates >= 0;
printf "Toss-up states    (%2u): %s\n", $swinoT, $swistT if $swinoT >= 1;
printf "Rep. tilt states  (%2u): %s\n", $#reptiltstates+1, $swistRTt if $#reptiltstates >= 0;
printf "Rep. lean states  (%2u): %s\n", $#repleanstates+1, $swistRLn if $#repleanstates >= 0;
printf "Rep. likely states(%2u): %s\n", $#replikelystates+1, $swistRLk if $#replikelystates >= 0;
printf "Rep. safe states  (%2u): %s\n", $#repsafestates+1, $swistRS if $#repsafestates >= 0;
printf "Democratic votes:   %3u\n", $demsafe if $demno > 0;
printf "Republican votes:   %3u\n", $repsafe if $repno > 0;
printf "Open votes:         %3u\n", $swingnum if $swino > 0;
printf "Open dem. votes:    %3u  %3u  %3u  %3u\n", $demsafe+$swingnumD, $demsafe+$swingnumDLn, $demsafe+$swingnumDLk, $demsafe+$swingnumDS if ($demsafe+$swingnumD) > 0;
printf "Open rep. votes:    %3u  %3u  %3u  %3u\n", $repsafe+$swingnumR, $repsafe+$swingnumRLn, $repsafe+$swingnumRLk, $repsafe+$swingnumRS if ($repsafe+$swingnumR) > 0;
printf "Open toss-up votes: %3u  %3u  %3u  %3u\n", $swingnumT, $swingnumTLn, $swingnumTLk, $swingnumTS if $swingnumTS > 0;
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
