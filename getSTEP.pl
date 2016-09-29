#!usr/bin/perl -w
#getting STEP file from "http://www.eldon.com"

use Data::Dumper;
use LWP::UserAgent;

#UserAgent Setting
my $ua = LWP::UserAgent->new(
	agent => "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36",
	timeout => 30,
);

#Url Target
my $starturl = 'http://www.eldon.com/123147_MAS-en_AU-Mild_steel_single_door_enclosure.aspx';

my $mainurl = 'http://www.eldon.com/';
my $url = $ua->get($starturl);
my $res = $url->content;

#Check available url
$i=0;

#MAS0202015R5-en_AU-Wall_mounted_200x200x155
while ($res =~ m/(MAS\d+[^-]+)(\D+)(.*)(\.aspx)/ig){
	my $link = $mainurl.$1.$2.$3.$4;
	my $name = $1.'_'.$3;
	print "STEP FILE NUMBER : ".$i." !!!\n";
	getSTEP($link, $name);
	$i++;
};

print "==> FINISH DOWNLOAD!!! <==";

#Download
sub getSTEP{
	my ($starturl, $name) = @_;
	my $url = $ua->get($starturl);
	my $res = $url->content;
	
	while ($res =~ m/(ServeAsset\.aspx\?asset\=[^"]+).*data\-eventlabel\=\"(.*)\"\>CAD drawing \(STEP\)/ig){
		my $name = $name.'.STEP';
		my $target = $mainurl.'Templates/Commerce/Pages/'.$1;
		print "Name\t=>\t".$name."\n";
		print "Target\t=>\t".$target."\n";
		print "Status\t=>";
		
		open FILE,">","$name";
		binmode FILE;
		print FILE $ua->get($target)->content;
		close FILE;
		
		print "\tFile has been saved!!!\n\n";
	};
};