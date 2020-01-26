package Elections;
use strict;
use FindBin;
use List::Util qw (reduce any all none notall first max maxstr min minstr product sum sum0 pairs unpairs pairkeys pairvalues pairgrep pairfirst pairmap shuffle uniq uniqnum uniqstr);
use Exporter qw(import);
our @EXPORT_OK = qw(get_statevals get_parstates check_par check_states get_closedstates get_openstates get_safeval get_swingperm commify sort_states delete_mainenebraska build_mat mene result_mat get_statedesc get_head build_permas modify_maine modify_nebraska print_info get_nome modify_results delete_doubles get_percent get_hvals);
use lib $FindBin::RealBin;
use HistElections qw(get_histvalues);

sub get_statevals {
  my %vals;
  open (VALS, "$FindBin::RealBin/statevals.dat") || die "Cannot open state values file\n";
  while(my $line = <VALS>){
    chomp($line);
    my @linearray = split(/:[\t]?/,$line);
    $vals{$linearray[0]} = $linearray[1];
  }
  close (VALS);
  return %vals;
}

sub get_parstates {
  my ($datfile,$sign) = @_;
  my @arr;
  open (DATA, "$datfile") || die "Cannot open data file\n";
  while(my $line = <DATA>){
    chomp($line);
    my @linearray = split(/:[\t]?/,$line);
    if($linearray[1] =~ /$sign/){
      push(@arr,$linearray[0]);
    } else {
      next;
    }
  }
  close (DATA);
  return @arr;
}

sub check_par {
 my @states = @_;
 my $mesum = 0;
 my $nesum = 0;
 my $me = 0; my $mea = 0; my $meb = 0; my $mex = 0; 
 my $ne = 0; my $nea = 0; my $neb = 0; my $nec = 0;
 foreach my $xxd (0..$#states){
  $me  = 1 if $states[$xxd] eq 'ME';
  $mea = 1 if $states[$xxd] eq 'ME1';
  $meb = 1 if $states[$xxd] eq 'ME2';
  $mex = 1 if $states[$xxd] =~ /ME[0-9]{1}/;
  $ne  = 1 if $states[$xxd] eq 'NE';
  $nea = 1 if $states[$xxd] eq 'NE1';
  $neb = 1 if $states[$xxd] eq 'NE2';
  $nec = 1 if $states[$xxd] eq 'NE3';
 }
 $nesum += 1 if $nec == 1;
 $nesum += 2 if $neb == 1;
 $nesum += 4 if $nea == 1;
 $nesum += 8 if $ne  == 1;
 $mesum += 1 if $meb == 1;
 $mesum += 2 if $mea == 1;
 $mesum += 4 if $me  == 1;
 return ($mesum,$nesum,$me,$mea,$meb,$mex,$ne,$nea,$neb,$nec);
}

sub check_states {
 my @states = @_;
 my @states_sorted = sort { $a cmp $b } @states;
 my $end = $#states_sorted - 1;
 my $y;
 foreach my $x (0..$end){
  $y = $x + 1;
  if ( $states_sorted[$x] =~ /$states_sorted[$y]/ ){
   print "Two states identical: $states_sorted[$x] and $states_sorted[$y]\n";
   exit;
  }
 }
}

# Combine 'D' and 'R' states/districts, calculate ME/NE values
sub get_closedstates {
 my ($arr1,$arr2,$ifme,$ifmea,$ifmeb,$ifne,$ifnea,$ifneb,$ifnec,$mesum,$nesum) = @_;
 my @outarr;
 my @inarr = (@$arr1, @$arr2);
 $$ifme = 0;
 $$ifmea = 0;
 $$ifmeb = 0;
 $$ifne = 0;
 $$ifnea = 0;
 $$ifneb = 0;
 $$ifnec = 0;
 foreach my $xa (0..$#inarr){
  $$ifme  = 4 if $inarr[$xa] eq 'ME';
  $$ifmea = 2 if $inarr[$xa] eq 'ME1'; 
  $$ifmeb = 1 if $inarr[$xa] eq 'ME2';
  $$ifne  = 8 if $inarr[$xa] eq 'NE';
  $$ifnea = 4 if $inarr[$xa] eq 'NE1';
  $$ifneb = 2 if $inarr[$xa] eq 'NE2';
  $$ifnec = 1 if $inarr[$xa] eq 'NE3';
 }
 $$mesum = $$ifme + $$ifmea + $$ifmeb;
 $$nesum = $$ifne + $$ifnea + $$ifneb + $$ifnec;
 @outarr = sort { $a cmp $b } @inarr;
 return @outarr;
}

# Describe open states/districts
sub get_openstates {
  my ($statevals,$allstates,$closedstates,$swingsts,$openvalx) = @_;
  my $var;
  foreach my $sx (0..$#$allstates) {
    $var = 0;
    foreach my $cx (0..$#$closedstates){
      if ( $$allstates[$sx] eq $$closedstates[$cx] ){
        $var = 1;
        last;
      }else{
        next;
      }
    }
    if ($var == 0){
      push (@$swingsts,$$allstates[$sx]);
      push (@$openvalx,$$statevals{$$allstates[$sx]});
    }
  }
}

# get safe values
sub get_safeval {
  my ($statevals,$parstates) = @_;
  my $val = 0;
  foreach my $x (0..$#$parstates) {
    $val += $$statevals{$$parstates[$x]};
  }
  return $val;
}

#  get number of open electors
sub get_swingperm {
  my ($statevals,$swingsts,$nrop) = @_;
  my $numm = 0;
  foreach my $x (0..$#$swingsts){
    $numm += $$statevals{$$swingsts[$x]};
    $$nrop *= 2;
  }
  return $numm;
}

# Write numbers with commas (as 1,000 separator)
sub commify {
 my $text = $_[0];
 $text =~ /([0-9]*)/;
 my $before = $1;
 my $erofeb = reverse $before;
 $erofeb =~ s/(\d\d\d)(?=\d)(?!\d*\.)/$1\,/g;
 my $befored = scalar reverse $erofeb;
 my $res = sprintf("% 26s",$befored);
 return $res;
}

# sort states alphabetically
sub sort_states {
  my @states = @_;
  my @states_sorted = sort { $a cmp $b } @states;
  my $statestring = join(' ',@states_sorted);
  return $statestring;
}

# Delete Maine and Nebraska from Open State List
sub delete_mainenebraska {
 my @inarr = @_;
 my $half = ($#inarr + 1)/2 - 1;
 my $halfpo = $half + 1;
 my @states = @inarr[0..$half];
 my @num = @inarr[$halfpo..$#inarr];
 my @outarr;
 foreach my $xxc (0..$#states){
   push(@outarr,$num[$xxc]) unless $states[$xxc] =~ /[MN]{1}E/;
 }
 return @outarr;
}

# Build original matrix to calculate uncorrected probabilities
sub build_mat {
 my ($j,$N,$ds,$messum,$nessum,$openvals) = @_;
 my @mainenebraskamat = mene($$messum[0], $$nessum[0], $$messum[1], $$nessum[1], $$messum[2], $$nessum[2]);
 my $z = $#mainenebraskamat;
 my @ref;
 my $dumvar;
 my $dummvar;
 my $t = $N + 1;
 my $k = $j - 1;
 foreach my $y (0..$N){
  if ($y >= $ds and $y <= ($ds + $z)){
   $ref[$y] = $mainenebraskamat[$y-$ds];
  }else{
   $ref[$y] = 0;
  }
 }
 foreach my $x (1..$j){
  foreach my $y (0..$N){
   if(($y - $$openvals[$x-1]) >= 0){
    $ref[$x*$t+$y] = $ref[($x-1)*$t+$y] + $ref[($x-1)*$t+($y-$$openvals[$x-1])];
   }else{
    $ref[$x*$t+$y] = $ref[($x-1)*$t+$y];
   }
  }
 }
return(@ref);
}

# Calculate ME/NE matrix
sub mene {
 my ($mes, $nes, $dmes, $dnes, $rmes, $rnes) = @_;
 my @memat;
 @memat = (1) if $mes == 7;
 @memat = (1,1) if ($mes == 5 or $mes == 6);
 @memat = (1,2,1) if $mes == 4;
 @memat = (0,0,1) if ($mes == 3 and $dmes == 3);
 @memat = (1,0.0) if ($mes == 3 and $dmes == 0);
 @memat = (1,0,1) if ($mes == 3 and $dmes < 3 and $dmes > 0);
 @memat = (1,0,1,1) if (($mes == 1 and $dmes == 1) or ($mes == 2 and $dmes == 2));
 @memat = (1,1,0,1) if (($mes == 1 and $dmes == 0) or ($mes == 2 and $dmes == 0));
 @memat = (1,2,0,2,1) if $mes == 0;
 my @nemat;
 @nemat = (1) if $nes == 15;
 @nemat = (1,1) if ($nes == 11 or $nes == 13 or $nes == 14);
 @nemat = (1,2,1) if ($nes == 9 or $nes == 10 or $nes == 12);
 @nemat = (1,3,3,1) if $nes == 8;
 @nemat = (0,0,1) if ($nes == 7 and $dnes == 7);
 @nemat = (1,0,0) if ($nes == 7 and $dnes == 0);
 @nemat = (1,0,1) if ($nes == 7 and $dnes < 7 and $dnes > 0);
 @nemat = (1,0,1,1) if (($nes == 3 and $dnes == 3) or ($nes == 5 and $dnes == 5) or ($nes == 6 and $dnes == 6));
 @nemat = (1,1,0,0) if (($nes == 3 and $dnes == 0) or ($nes == 5 and $dnes == 0) or ($nes == 6 and $dmes == 0));
 @nemat = (1,1,1,1) if (($nes == 3 and $dnes < 3 and $dnes > 0) or ($nes == 5 and $dnes < 5 and $dnes > 0) or ($nes == 6 and $dnes < 6 and $dnes > 0));
 @nemat = (1,1,1,1,1) if ($nes == 1 or $nes == 2 or $nes == 4);
 @nemat = (1,3,3,3,3,1) if $nes == 0;
 my @menemat;
 my $up = $#memat + $#nemat;
 my $max;
 my $rem;
 foreach my $zv (0..$up){
  $max = min($#memat,$zv);
  $menemat[$zv] = 0;
  foreach my $zw (0..$max){
   $rem = $zv - $zw;
   $menemat[$zv] += ($memat[$zw] * $nemat[$rem]) unless ($rem < 0 or $rem > $#nemat);
  }
 }
 return(@menemat);
}

# Build result matrix with uncorrected probabilities
sub result_mat {
 my ($inarr,$sx) = @_;
 my @outarr;
 my $dsum;
 my $rsum;
 my $tsum;
 $dsum = 0;
 $rsum = 0;
 $tsum = 0;
 foreach my $x (0..268) {
  $rsum += $$inarr[($sx+1)*539+$x];
 }
 $tsum = $$inarr[($sx+1)*539+269];
 foreach my $x (270..538) {
  $dsum += $$inarr[($sx+1)*539+$x];
 }
 my $tot = $rsum + $tsum + $dsum;
 @outarr = ($rsum,$tsum,$dsum,$tot);
 return(@outarr);
}

# Reformat state descriptiors for CDs of ME/NE
sub get_statedesc {
  my @swingsts = @_;
  my @statedesc;
  foreach my $xsw (0..$#swingsts) {
    $statedesc[$xsw] = $swingsts[$xsw];
  }
  return @statedesc;
}

sub get_head {
  my ($swingnumm, $statedesc, $openvals) = @_;
  my $heada = sprintf("%-3s" x $swingnumm . " WIN  EVs      MULT \n", @$statedesc); 
  my $headb = sprintf("%2u " x $swingnumm . "\n", @$openvals); 
  my $headc = sprintf("---" x $swingnumm . "----------------------\n");
  my $head = $heada . $headb . $headc;
  return $head;
}

# Generate first matrix for variations
sub build_permas {
  my ($mod,$count,$pbs,$swingnumm,$statevals,$swingsts,$safe,$permas,$winners) = @_;
  my $demadd; my $repadd;
  my $demsafe = $$safe[0]; my $repsafe = $$safe[1]; my $needed = $$safe[2];
  if ($mod eq 'B'){
    foreach my $xp (0..$#$pbs){
     my $lpb = length($$pbs[$xp])-1;
     $demadd = 0;
     $repadd = 0;
     foreach my $xl (0..$lpb){
      $$permas[$xp*$swingnumm+$xl] = substr($$pbs[$xp],$xl,1);
      $demadd += $$statevals{$$swingsts[$xl]} if $$permas[$xp*$swingnumm+$xl] eq 'D';
      $repadd += $$statevals{$$swingsts[$xl]} if $$permas[$xp*$swingnumm+$xl] eq 'R';
     }
     $$winners[$xp] = 'D' if ($demsafe + $demadd) >= $needed;
     $$winners[$xp] = 'R' if ($repsafe + $repadd) >= $needed;
     $$winners[$xp] = 'T' if (($repsafe + $repadd) < $needed and ($demsafe + $demadd) < $needed);
    }
   }elsif($mod eq 'V'){
    $demadd = 0;
    $repadd = 0;
    foreach my $xl (0..$#$pbs){
     $$permas[$count*$swingnumm+$xl] = $$pbs[$xl];
     $demadd += $$statevals{$$swingsts[$xl]} if $$permas[$count*$swingnumm+$xl] eq 'D';
     $repadd += $$statevals{$$swingsts[$xl]} if $$permas[$count*$swingnumm+$xl] eq 'R';
    }
    $$winners[$count] = 'D' if ($demsafe + $demadd) >= $needed;
    $$winners[$count] = 'R' if ($repsafe + $repadd) >= $needed;
    $$winners[$count] = 'T' if (($repsafe + $repadd) < $needed and ($demsafe + $demadd) < $needed);
   }
}

# Delete non-sensible results concerning ME (e.g. ME:D ME1:R ME2:R or ME:R ME1:D ME2:D)
sub modify_maine {
 my ($np,$swn,$mes,$dmes,$rmes,$swingsts,$permas,$permbs,$winners,$winna) = @_;
 my $nome; my $nomex; my $nomea; my $nomeb;
 foreach my $xxy (0..($swn-1)){
  $nome  = $xxy if $$swingsts[$xxy] eq 'ME';
  $nomex = $xxy if $$swingsts[$xxy] =~ /ME/ and $$swingsts[$xxy] ne 'ME';
  $nomea = $xxy if $$swingsts[$xxy] eq 'ME1';
  $nomeb = $xxy if $$swingsts[$xxy] eq 'ME2';
 }
 my @vme  = @$permas[ map { $swn * $_ + $nome  } 0..$np ] if defined $nome;
 my @vmex = @$permas[ map { $swn * $_ + $nomex } 0..$np ] if defined $nomex;
 my @vmea = @$permas[ map { $swn * $_ + $nomea } 0..$np ] if defined $nomea;
 my @vmeb = @$permas[ map { $swn * $_ + $nomeb } 0..$np ] if defined $nomeb;
 if($mes == 1 or $mes == 2){
  if($dmes == 1 or $dmes == 2){
   my $xxy = 0;
   while ($xxy < $np){
    if($vme[$xxy] eq 'R' and $vmex[$xxy] eq 'D'){
     $xxy++;
    }else{
     push(@$permbs,@$permas[ map { $xxy*$swn + $_ } 0..($swn-1)]);
     push(@$winna,$$winners[$xxy]);
     $xxy++;
    }
   }
  }else{
   my $xxy = 0;
   while ($xxy < $np){
    if($vme[$xxy] eq 'D' and $vmex[$xxy] eq 'R'){
     $xxy++;
    }else{
     push(@$permbs,@$permas[ map { $xxy*$swn + $_ } 0..($swn-1)]);
     push(@$winna,$$winners[$xxy]);
     $xxy++;
    }
   }
  }
 }elsif($mes == 0){
  my $xxy = 0;
  while ($xxy < $np){
   if($vme[$xxy] eq 'R' and $vmea[$xxy] eq 'D' and $vmeb[$xxy] eq 'D'){
    $xxy++;
   }elsif($vme[$xxy] eq 'D' and $vmea[$xxy] eq 'R' and $vmeb[$xxy] eq 'R'){
    $xxy++;
   }else{
    push(@$permbs,@$permas[ map {$xxy*$swn + $_ } 0..($swn-1)]);
    push(@$winna,$$winners[$xxy]);
    $xxy++;
   }
  }
 }else{
  @$permbs = @$permas;
  @$winna  = @$winners;
 }
}

# Delete non-sensible results concerning NE
sub modify_nebraska {
 my ($nrp,$swn,$nesum,$dnesum,$rnesum,$swingsts,$permbs,$permcs,$winna,$winnb) = @_;
 my $none; my $nonea; my $noneb; my $nonec;
 foreach my $xxy (0..($swn-1)){
  $none  = $xxy if $$swingsts[$xxy] eq 'NE';
  $nonea = $xxy if $$swingsts[$xxy] eq 'NE1';
  $noneb = $xxy if $$swingsts[$xxy] eq 'NE2';
  $nonec = $xxy if $$swingsts[$xxy] eq 'NE3';
 }
 my @vne  = @$permbs[ map {$swn * $_ + $none  } 0..$nrp ] if defined $none;
 my @vnea = @$permbs[ map {$swn * $_ + $nonea } 0..$nrp ] if defined $nonea;
 my @vneb = @$permbs[ map {$swn * $_ + $noneb } 0..$nrp ] if defined $noneb;
 my @vnec = @$permbs[ map {$swn * $_ + $nonec } 0..$nrp ] if defined $nonec;
 if ($nesum == 15 or $nesum == 14 or $nesum == 13 or $nesum == 12 or $nesum == 11 or $nesum == 10 or $nesum == 9){
   @$permcs = @$permbs;
   @$winnb  = @$winna;
 }elsif($nesum == 3){
   if($dnesum == 3){
    my $xxy = 0;
    while ($xxy < $nrp){
     if($vne[$xxy] eq 'R' and $vnea[$xxy] eq 'D'){
      $xxy++;
     }else{
      push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
      push(@$winnb,$$winna[$xxy]);
      $xxy++;
     }
    }
   }elsif($rnesum == 3){
    my $xxy = 0;
    while ($xxy < $nrp){
     if($vne[$xxy] eq 'D' and $vnea[$xxy] eq 'R'){
      $xxy++;
     }else{
      push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
      push(@$winnb,$$winna[$xxy]);
      $xxy++;
     }
    }
   }else{
    @$permcs = @$permbs;
    @$winnb  = @$winna;
   }
  }elsif($nesum == 5){
   if($dnesum == 5){
    my $xxy = 0;
    while ($xxy < $nrp){
     if($vne[$xxy] eq 'R' and $vneb[$xxy] eq 'D'){
      $xxy++;
     }else{
      push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
      push(@$winnb,$$winna[$xxy]);
      $xxy++;
     }
    }
   }elsif($rnesum == 5){
    my $xxy = 0;
    while ($xxy < $nrp){
     if($vne[$xxy] eq 'D' and $vneb[$xxy] eq 'R'){
      $xxy++;
     }else{
      push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
      push(@$winnb,$$winna[$xxy]);
      $xxy++;
     }
    }
   }else{
    @$permcs = @$permbs;
    @$winnb  = @$winna;
   }
 }elsif($nesum == 6){
  if($dnesum == 6){
   my $xxy = 0;
   while($xxy < $nrp){
    if($vne[$xxy] eq 'R' and $vnec[$xxy] eq 'D'){
     $xxy++;
    }else{
     push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
     push(@$winnb,$$winna[$xxy]);
     $xxy++;
    }
   }
  }elsif($rnesum == 6){
   my $xxy = 0;
   while($xxy < $nrp){
    if($vne[$xxy] eq 'D' and $vnec[$xxy] eq 'R'){
     $xxy++;
    }else{
     push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
     push(@$winnb,$$winna[$xxy]);
     $xxy++;
    }
   }
  }else{
   @$permcs = @$permbs;
   @$winnb  = @$winna;
  }
 }elsif($nesum == 0){
  my $xxy = 0;
  while($xxy < $nrp){
   if($vne[$xxy] eq 'D' and $vnea[$xxy] eq 'R' and $vneb[$xxy] eq 'R' and $vnec[$xxy] eq 'R'){
    $xxy++;
   }elsif($vne[$xxy] eq 'R' and $vnea[$xxy] eq 'D' and $vneb[$xxy] eq 'D' and $vnec[$xxy] eq 'D'){
    $xxy++;
   }else{
    push(@$permcs,@$permbs[ map {$xxy*$swn + $_ } 0..($swn-1)]);
    push(@$winnb,$$winna[$xxy]);
   }
  }
 }else{
  @$permcs = @$permbs;
  @$winnb  = @$winna;
 }
}

# Calculate and print corrected probabilities
sub print_info {
  my @winnb = @_;
  my $pd = 0;
  my $pr = 0;
  my $pt = 0;
  foreach my $xxw (0..$#winnb){
    $pd++ if $winnb[$xxw] eq 'D';
    $pr++ if $winnb[$xxw] eq 'R';
    $pt++ if $winnb[$xxw] eq 'T';
  }
  my $nrp = $pd + $pr + $pt;
  my $dempercent = 100 * $pd / $nrp;
  my $reppercent = 100 * $pr / $nrp;
  my $tiepercent = 100 * $pt / $nrp;
  print "Corrected probabilities\n";
  printf "All szenarios:    %7u (%8.4f %%)\n", $nrp, 100;
  printf "Dem. probability: %7u (%8.4f %%)\n", $pd, $dempercent;
  printf "Rep. probability: %7u (%8.4f %%)\n", $pr, $reppercent;
  printf "Tie probability:  %7u (%8.4f %%)\n", $pt, $tiepercent;
}

sub get_nome {
  my @swingsts = @_;
  my $nme;
  my $nmx;
  my $swin = $#swingsts + 1;
  foreach my $xxs (0..($swin-1)){
    $nme = $xxs if $swingsts[$xxs] eq 'ME';
    $nmx = $xxs if ($swingsts[$xxs] =~ /ME/ and $swingsts[$xxs] ne 'ME');
  }
  my @nm = ($nme, $nmx);
  return @nm;
}

# Group similar results
sub modify_results {
 my ($nrp,$swingnr,$nme,$nmx,$demsafe,$repsafe,$needed,$permcs,$statevals,$swingsts) = @_;
 my $dadd;
 my $radd;
 my $checkmark;
 my $demgap = $needed - $demsafe;
 my $repgap = $needed - $repsafe;
 my $swingnumm = $swingnr;
 my @linx;
 my @links;
 my @demvotas; my @repvotas; my @winnaz; my @linea;
 foreach my $bb (0..($nrp-1)){
  $dadd = 0;
  $radd = 0;
  $checkmark = ($demsafe >= $needed or $repsafe >= $needed) ? 1 : 0;
  foreach my $cc (0..($swingnr-1)){
   if($checkmark == 1 and $cc != ($swingnr-1)){
     $$permcs[$bb*$swingnr+$cc] = 'X';
     next;
   }elsif($checkmark == 1 and $cc == ($swingnr-1)){
     $$permcs[$bb*$swingnr+$cc] = 'X';
     goto RLIN;
   }else{
    $dadd += $$statevals{$$swingsts[$cc]} if $$permcs[$bb*$swingnr+$cc] eq 'D';
    $radd += $$statevals{$$swingsts[$cc]} if $$permcs[$bb*$swingnr+$cc] eq 'R';
    $checkmark = 1 if ($dadd >= $demgap or $radd >= $repgap);
   }
  }
  RLIN:
  @linx = @$permcs[($bb*$swingnumm)..(($bb+1)*$swingnumm-1)];
  $links[$bb] = join('  ',@linx);
  $demvotas[$bb] = $demsafe + $dadd;
  $repvotas[$bb] = $repsafe + $radd;
  if($dadd >= $demgap){
   $winnaz[$bb] = 'DEM';
   $linea[$bb] = sprintf("%s  " x $swingnumm . " %3s  %3i:%3i", @linx, $winnaz[$bb], $demvotas[$bb], $repvotas[$bb]);
  }elsif($radd >= $repgap){
   $winnaz[$bb] = 'REP';
   $linea[$bb] = sprintf("%s  " x $swingnumm . " %3s  %3i:%3i", @linx, $winnaz[$bb], $repvotas[$bb], $demvotas[$bb]);
  }else{
   $winnaz[$bb] = 'TIE';
   $linea[$bb] = sprintf("%s  " x $swingnumm . " %3s  %3i:%3i", @linx, $winnaz[$bb], 269, 269);
  }
 }
 return @linea;
}

# Delete double lines
sub delete_doubles {
  my ($nrp,$linea) = @_;
  my $mt;
  foreach my $bb (0..($nrp-1)){
    if(defined $$linea[$bb]){
      $mt = 1;
      foreach my $cc (($bb+1)..($nrp-1)){
        $$linea[$bb] eq $$linea[$cc] ? $mt++ : last;
      }
      foreach my $cc (($bb+1)..($bb+$mt-1)) {
        undef $$linea[$cc];
      }
      $$linea[$bb] = sprintf("%s x %6u\n",$$linea[$bb],$mt);
    }
  }
  my $nrosp = 0;
  foreach my $bb (0..($nrp-1)){
    my $vali = $bb - $nrosp;
    if(defined $$linea[$vali]){
      next;
    }else{
      splice(@$linea,$vali,1);
      $nrosp++;
    }
  }
}

sub get_percent {
  my %perc;
  open(PERC,"./prespercent.dat") || die "Cannot open percentage file\n";
  while (my $line = <PERC>){
    $line =~ /([A-Z]{2}[0-9]?):[\t]?([0-9\.]*)[\t](0-9\.)*/;
    my $state = $1;
    my $dem = $2;
    my $rep = $3;
    $perc{$state} = { "D" => $dem, "R" => $rep };
  }
  return %perc;
}

sub get_hvals {
  my $year = shift;
  my %histvals = get_histvalues();
  my %hvals;
  my @histkeys = keys %histvals;
  foreach my $xh (0..$#histkeys) {
    if(exists $histvals{$histkeys[$xh]}{$year}) {
      $hvals{$histkeys[$xh]} = $hvals{$histkeys[$xh]}{$year};
    }
  }
  return %hvals;
}

1;
