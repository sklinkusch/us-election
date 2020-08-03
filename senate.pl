#!/usr/bin/perl -w

use strict;
use warnings;
no warnings 'experimental';
use v5.10;
use List::Util qw(min max);

my @totstates = getStatesSenate();
my %statevals = getStatevalsSenate(@totstates);
my $moddus = 2; # 0: without percentage, 1: with percentage, 2: read percentage from file
my %percent = getPercentSenate();
my @dmStates;
my @rpStates;

# Class I seats
my @classA = ("AZa", "CAa", "CTa", "DEa", "FLa", "HIa", "INa", "MAa", "MDa", "MEa", "MIa", "MNa", "MOa", "MSa", "MTa", "NDa", "NEa", "NJa", "NMa", "NVa", "NYa", "OHa", "PAa", "RIa", "TNa", "TXa", "UTa", "VAa", "VTa", "WAa", "WIa", "WVa", "WYa");
my @dema = (0, 1, 2, 3, 5, 7, 8, 9, 10, 11, 14, 17, 18, 19, 20, 21, 22, 23, 27, 28, 29, 30, 31);
my @repa = (4, 6, 12, 13, 15, 16, 24, 25, 26, 32);
my @demA = map { $classA[$_] } @dema;
my @repA = map { $classA[$_] } @repa;

# Class II seats
my @classB = ("AKb", "ALb", "ARb", "COb", "DEb", "GAb", "IAb", "IDb", "ILb", "KSb", "KYb", "LAb", "MAb", "MEb", "MIb", "MNb", "MSb", "MTb", "NCb", "NEb", "NHb", "NJb", "NMb", "OKb", "ORb", "RIb", "SCb", "SDb", "TNb", "TXb", "VAb", "WVb", "WYb");
my @demb = (1,4,8,12,14,15,20,21,22,24,25,30);
my @repb = (0,2,3,5,6,7,9,10,11,13,16,17,18,19,23,26,27,28,29,31,32);
my @demB = map { $classB[$_] } @demb;
my @repB = map { $classB[$_] } @repb;

# Class III Seats
my @classC = ("AKc", "ALc", "ARc", "AZc", "CAc", "COc", "CTc", "FLc", "GAc", "HIc", "IAc", "IDc", "ILc", "INc", "KSc", "KYc", "LAc", "MDc", "MOc", "NCc", "NDc", "NHc", "NVc", "NYc", "OHc", "PAc", "SCc", "SDc", "UTc", "VTc", "WAc", "WIc");
my @demc = (4,5,6,9,12,17,21,22,23,26,31,32);
my @repc = (0,1,2,3,7,8,10,11,13,14,15,16,18,19,20,24,25,27,28,29,30,33);
my @demC = map { $classC[$_] } @demc;
my @repC = map { $classC[$_] } @repc;

# Election modus and special elections
my $modeElection = 5;
my @specelec = getSpecElections();

# Closed states (w/o special elections)
my @demAClosed = crossout(\@demA, \@specelec);
my @repAClosed = crossout(\@repA, \@specelec);
my @demBClosed = crossout(\@demB, \@specelec);
my @repBClosed = crossout(\@repB, \@specelec);
my @demCClosed = crossout(\@demC, \@specelec);
my @repCClosed = crossout(\@repC, \@specelec);

# find closed states
given($modeElection) {
	when(6) {
		@dmStates = (@demAClosed, @demBClosed);
		@rpStates = (@repAClosed, @repBClosed);
		break;
	}
	when(5) {
		@dmStates = (@demAClosed, @demCClosed);
		@rpStates = (@repAClosed, @repCClosed);
		break;
	}
	when(3) {
		@dmStates = (@demBClosed, @demCClosed);
		@rpStates = (@repBClosed, @repCClosed);
		break;
	}
	default {
		@dmStates = (@demAClosed, @demBClosed, @demCClosed);
		@rpStates = (@repAClosed, @repBClosed, @repCClosed);
	}
}
my @closedstatesRaw = (@dmStates, @rpStates);
my @closedStates = sort { $a cmp $b } @closedstatesRaw;
my @openstates = getOpen();