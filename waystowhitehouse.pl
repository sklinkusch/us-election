#!/usr/bin/perl -w
# Preface
use strict;
use warnings;
use Algorithm::Combinatorics qw/variations_with_repetition/;
use List::Util qw(first);
use Cwd 'abs_path';
use FindBin;
use lib $FindBin::RealBin;
use Elections qw(get_statevals get_parstates check_par check_states get_closedstates get_safeval get_swingperm commify sort_states delete_mainenebraska build_mat result_mat get_statedesc get_head build_permas modify_maine modify_nebraska print_info get_nome modify_results delete_doubles get_mustwin);

if ($#ARGV < 0){
	print "Usage: waystowhitehouse.pl <data file>\n";
	print "data file contains all states/districts with D/R/X notifier\n";
	exit;
}
my $datfile = join('',$ARGV[0]);
my $fulldat = abs_path($datfile);

# get the states and the respective number of electors
my %statevals = get_statevals();

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
Elections::get_openstates(\%statevals,\@allstates,\@closedstates,\@swingsts,\@openvalx);
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
printf("Number of permutations:        %26s\n",$nropx);

# Calculate and print probabilities (without correction)
my @swinr = delete_mainenebraska(@swingsts,@openvals);
my $ifmaineclosed;
my $ifnebraskaclosed;
my @messum = ($mesum, $dmesum, $rmesum);
my @nessum = ($nesum, $dnesum, $rnesum);
my @demmat = build_mat($#swinr+1,538,$demsafe,\@messum,\@nessum,\@openvals);
my @repmat = build_mat($#swinr+1,538,$repsafe,\@messum,\@nessum,\@openvals);
my @resamat = result_mat(\@demmat,$#swinr);
my $szenarios = $resamat[3];
my $nonsens = $nrop - $szenarios;
my $nonsensx = commify($nonsens);
my $szenariosx = commify($szenarios);
printf("Non-sensible permutations:     %26s\n", $nonsensx);
printf("Szenarios gesamt:              %26s\n", $szenariosx);
## Calculating tie probability
my $summt = $resamat[1];
my $summtx = commify($summt);
my $tieprob = 100 * $summt / $szenarios;

if ($summt != 0){
	printf("Tie probability:   %8.4f %%  %26s\n", $tieprob, $summtx);
}
## Calculating Dem probability
my $summd = $resamat[2];
my $summdx = commify($summd);
my $demprob = 100 * $summd / $szenarios;
if ($summd != 0){
	printf("Dem. probability:  %8.4f %%  %26s\n", $demprob, $summdx);
}
## Calculating Rep probability
my $summr = $resamat[0];
my $summrx = commify($summr);
my $repprob = 100 * $summr / $szenarios;
if ($summr != 0){
	printf("Rep. probability:  %8.4f %%  %26s\n", $repprob, $summrx);
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
	print_info(@winnb);
	my ($nome, $nomex) = get_nome(@swingsts);
	my @linea = modify_results($dummyvar,$swino,$nome,$nomex,$demsafe,$repsafe,$needed,\@permcs,\%statevals,\@swingsts);
	delete_doubles($dummyvar,\@linea);

	if($demsafe < $needed and $repsafe < $needed){
		my @mustwin = get_mustwin(\@linea,\@statedesc);
		print join('',@mustwin) if ($#mustwin > -1);
		print $head;
		print join('',@linea);
	}
}
