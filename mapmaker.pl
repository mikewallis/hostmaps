#!/usr/bin/perl
use warnings;
use strict;

my @res;
my $name;
my @host_list;
my @hostgroup_list;

my $filename = $ARGV[0];
#print "filename: $filename\n";

open my $FH, '<', $filename or die $!;
while(my $line = <$FH>){
	chomp $line;
	$line =~ s/\\//g;
	my @lines = split(" ", $line);
	push(@res, @lines);
}
#my @lines = <$FH>;
close($FH);

my $array_len = @res;
#print "array_length: $array_len\n";

my ( $name_index ) = grep { $res[$_] =~ /group_name/ } 0..$#res;
my ( $host_index ) = grep { $res[$_] =~ /hostlist/ } 0..$#res;

#print "name index: $name_index\n";
#print "host index: $host_index\n";
my $group_name = $res[$name_index+1];
#my $host_list = $res[$host_index+1];

for my $i ($host_index+1 .. $array_len-1)
{
	if ($res[$i] =~ /^@/) {
		push(@hostgroup_list, $res[$i]);
	} else {
		push(@host_list, $res[$i]);
	}
}
#print "name: $group_name\n";
#print "hostgroups: @hostgroup_list\n";
#print "list: @host_list\n";

for my $elem (@hostgroup_list) {
	print "$group_name -> $elem\n";
}
#for my $elem (@host_list) {
#	print "$elem\n";
#}
