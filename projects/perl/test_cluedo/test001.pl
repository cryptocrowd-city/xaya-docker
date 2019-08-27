use v5.10;
use lib '/home/cymon/works/xaya/projects/perl';
use XAYA::Test;
use XAYA::Cluedo;
use Data::Dumper;

my $test = XAYA::Test->new( game => XAYA::Cluedo->new( test => 1 ));

my $n = 


my $test_case = {
    notification => $test->build_notification('attack', 'cymon', { action => 'join' }),
    outcome => { type => 'partial',
                 content => 
                    { 'players.0.name' => 'cymon',
                      '?players.0.character' => [ 'Mrs. White', 'Mr. Green', 'Mrs. Peacock', 'Professor Plum', 'Miss Scarlet', 'Colonel Mustard' ]  
                    }
               }
};
$test->add_test($test_case);
$test->run;




