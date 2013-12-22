#!/usr/bin/perl
#
# loteria_check.pl <llistat particions file>
#  - llistat_participacions_file: num participacio:apostat:comentari
# author: Marc Rabell m.rabell@gmail.com
# v2.20131222
# 

use warnings;
use LWP::Simple;

$invertit = $guanyat = 0;

open(LLISTA, $ARGV[0]) or die("No puc obrir fitxer amb la llista de participacions");
foreach (<LLISTA>){
  chomp;
  ($num,$import,$comment) = $_ =~ /(\d+):(\d+\.?\d?\d?):(.*)/;
  $premi_html = get("http://loteriadenavidad.laverdad.es/fcgi-bin/premio.pl?numero=$num&importe=$import");
  $premi_html =~ /"lot6">(\S+)\s/;
  print "Num $num: posats $import€ rebuts $1 ($comment)\n";
  $guanyat += $1 unless $1 =~ /No/;
  $invertit += $import;
}

print "Total invertit: $invertit€\n";
print "Total guanyat: $guanyat€\n";
$roi = $guanyat/$invertit*100;
print sprintf "Un %.1f%% de ROI\n", $roi;

exit 0;
