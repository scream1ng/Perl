#!usr/bin/perl -w
#getting STEP file from "http://www.eldon.com"

use Data::Dumper;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new(
	agent => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36",
	timeout => 30,
);

my $mainurl = 'http://www.eldon.com/';
my $url = $ua->get('http://www.eldon.com/123147_MAS-en_AU-Mild_steel_single_door_enclosure.aspx');
my $res = $url->content;

#<a href="/MAS0202015R5-en_AU-Wall_mounted_200x200x155.aspx">MAS0202015R5</a>
my $i = 0;
while ($res =~ /(MAS\d+.*\.aspx)/i){
last if ($i == 10);
my $link = $1;
print $link."\n";
$i++;
};