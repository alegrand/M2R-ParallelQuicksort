
use strict;

my($line);
my($size);

print "Size, Type, Time\n" ;
while($line=<>) {
    chomp $line;
    if($line =~/^Size: ([\d\.]*)$/) {
        $size = $1;
        next;
    } 
    if($line =~/^(.*) quicksort.*: ([\d\.]*) sec.$/) {
        print "$size, \"$1\", $2\n" ;
        next;
    } 
}
