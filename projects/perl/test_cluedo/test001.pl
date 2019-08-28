use v5.10;
use lib '/home/cymon/works/xaya/projects/perl';
use XAYA::Test;
use XAYA::Cluedo;
use Data::Dumper;
use DateTime;

my $test = XAYA::Test->new( game => XAYA::Cluedo->new( test => 1 ));

my $rooms = $test->game->rooms; 
my $characters = $test->game->characters; 
my $weapons = $test->game->weapons; 




my $test_case_0 = {
    outcome => {type => 'partial',
                content =>
                    { '?solution.character' => $characters,
                      '?solution.room' => $rooms,
                      '?solution.weapon' => $weapons
                    }
                }
};
$test->add_test($test_case_0);

my $test_case_1 = {
    notification => $test->build_notification('attack', 'cymon', { action => 'join' }),
    outcome => { type => 'partial',
                 content => 
                    { 'players.0.name' => 'cymon',
                      '?players.0.character' => $characters,  
                      '?players.0.position' => $rooms,  
                    }
               }
};
$test->add_test($test_case_1);
my $test_case_2 = {
    change => { 'players.0.position' => 'Kitchen' },
    notification => $test->build_notification('attack', 'cymon', { action => 'move', destination => 'Ballroom' }),
    outcome => { type => 'partial',
                 content => { 'players.0.position' => 'Kitchen' } }
}; 
$test->add_test($test_case_2);
my $past_ts = DateTime->now();
$past_ts->add( hours => -2);
my $test_case_3 = {
    change => { 'players.0.ongoing.timestamp' => $past_ts },
    notification => $test->build_notification('void', 'cymon', { }),
    outcome => {type => 'partial',
                content => {'players.0.position' => 'Ballroom',
                            'players.0.ongoing' => undef } }
};
$test->add_test($test_case_3);
    

$test->run;




