#!/usr/bin/perl -w
# Preface
use strict;
use warnings;
use Algorithm::Combinatorics qw/variations_with_repetition/;
use List::Util qw(first);
use Math::BigFloat;
use FindBin;
use lib $FindBin::RealBin;
use Elections qw(get_statevals get_parstates check_par check_states get_openstates get_safeval get_swingperm commify sort_states delete_mainenebraska build_mat result_mat get_statedesc get_head build_permas modify_maine modify_nebraska print_info get_nome modify_results delete_doubles get_percent closed_simple build_matpc commify_float);

if ($#ARGV < 1){
	print "Usage: presprob-pc.pl <data file> <percent file>\n";
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
check_states(@demstates,@repstates);
my @closedstates = closed_simple(\@demstates,\@repstates);
my @openvalx;
my @swingsts;
get_openstates(\%statevals,\@allstates,\@closedstates,\@swingsts,\@openvalx);
my @openvals = sort { $b <=> $a } @openvalx;
my $perms = $#swingsts + 1;
my $demsafe = get_safeval(\%statevals,\@demstates);
my $repsafe = get_safeval(\%statevals,\@repstates);
my $nrop = 1;
my $swingnum = get_swingperm(\%statevals,\@swingsts,\$nrop);
my @swingstsD = grep { $dsperc{$_} > $rsperc{$_} } @swingsts;
my @swingstsDS = grep { $dsperc{$_} >= 99.5 } @swingstsD;
my @swingstsDLk = grep { $dsperc{$_} >= 90.0 } @swingstsD;
my @swingstsDLn = grep { $dsperc{$_} >= 65.0 } @swingstsD;
my @demsafestates = @swingstsDS;
my @demlikelystates = grep { $dsperc{$_} < 99.5 } @swingstsDLk;
my @demleanstates = grep { $dsperc{$_} < 90.0 } @swingstsDLn;
my @demtiltstates = grep { $dsperc{$_} < 65.0 } @swingstsD;
my @swingstsR = grep { $rsperc{$_} > $dsperc{$_} } @swingsts;
my @swingstsRS = grep { $rsperc{$_} >= 99.5 } @swingstsR;
my @swingstsRLk = grep { $rsperc{$_} >= 90.0 } @swingstsR;
my @swingstsRLn = grep { $rsperc{$_} >= 65.0 } @swingstsR;
my @repsafestates = @swingstsRS;
my @replikelystates = grep { $rsperc{$_} < 99.5 } @swingstsRLk;
my @repleanstates = grep { $rsperc{$_} < 90.0 } @swingstsRLn;
my @reptiltstates = grep { $rsperc{$_} < 65.0 } @swingstsR;
my @swingstsT = grep { $dsperc{$_} == $rsperc{$_} } @swingsts;
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
printf("Number of permutations:         %26s\n",$nropx);

# Calculate and print probabilities (without correction)
my @demmat = build_matpc($swino,$total,$demsafe,\@openvals, \@swingsts,\%dsperc);
my @repmat = build_matpc($swino,$total,$repsafe,\@openvals, \@swingsts,\%rsperc);
my @resamat = result_mat(\@demmat,$#swingsts);
my $szenarios = $resamat[3];

# my $nonsens = $nrop - $szenarios;
# my $nonsensx = commify($nonsens);
my $szenars = sprintf("% 26.4f",$szenarios);
my $szenariosx = commify_float($szenars);

# printf("Non-sensible permutations:     %26s\n", $nonsensx);
printf("Szenarios gesamt:              %32s\n", $szenariosx);

# Calculating tie probability
my $summt = sprintf("% 26.4f",$resamat[1]);
my $summtx = commify_float($summt);
my $tieprob = 100 * $summt / $szenarios;

if ($summt != 0){
	printf("Tie probability:   %8.4f %%  %32s\n", $tieprob, $summtx);
}

# Calculating Dem probability
my $summd = sprintf("% 26.4f",$resamat[2]);
my $summdx = commify_float($summd);
my $demprob = 100 * $summd / $szenarios;
if ($summd != 0){
	printf("Dem. probability:  %8.4f %%  %32s\n", $demprob, $summdx);
}

# Calculating Rep probability
my $summr = sprintf("% 26.4f",$resamat[0]);
my $summrx = commify_float($summr);
my $repprob = 100 * $summr / $szenarios;
if ($summr != 0){
	printf("Rep. probability:  %8.4f %%  %32s\n", $repprob, $summrx);
}
