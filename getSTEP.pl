#!usr/bin/perl -w
#getting STEP file from "http://www.eldon.com"

use Data::Dumper;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new(
	agent => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36",
	timeout => 30,
);

my $mainurl = 'http://www.eldon.com/';
my $url = $ua->get('http://www.eldon.com/MAS0202015R5-en_AU-Wall_mounted_200x200x155.aspx');
my $res = $url->content;

=Dumpsc
#http://www.eldon.com/Templates/Commerce/Pages/ServeAsset.aspx?asset=3311280
open FILE,">","Dump.txt";
print FILE $res;
close FILE;
=cut

#<a href="/Templates/Commerce/Pages/ServeAsset.aspx?asset=3311280" target="_blank" class="event-productfile" data-eventlabel="MAS0202015R5">CAD drawing (STEP)</a>
$res =~ /(ServeAsset\.aspx\?asset\=[^"]+)(.*)(CAD drawing \(STEP\))/i;
$target = $mainurl.$1;
print $target;
