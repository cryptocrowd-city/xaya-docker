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

say "Init and Join tests";




$test->add_test({
    outcome => [{type => 'partial',
                content =>
                    { '?solution.character' => $characters,
                      '?solution.room' => $rooms,
                      '?solution.weapon' => $weapons
                    }
                }]
});

$test->add_test({
    notification => $test->build_notification('attack', 'cymon', { action => 'join' }),
    outcome => [{ type => 'partial',
                 content => 
                    { 'players.0.name' => 'cymon',
                      '?players.0.character' => $characters,  
                      '?players.0.position' => $rooms,  
                    }
               }]
});
$test->add_test({
    notification => $test->build_notification('attack', 'cymon', { action => 'join' }),
    outcome => [{ type => 'log',
                 content => 
                    { '0' => 'Player already present' }
               }]
});

my $index = 1;
foreach my $new ( 'second', 'third', 'fourth', 'fifth', 'sixth' )
{
    $test->add_test({
        notification => $test->build_notification('attack', $new, { action => 'join' }),
        outcome => [{ type => 'partial',
                    content => 
                        { "players.$index.name" => $new,
                        "?players.$index.character" => $characters,  
                        "?players.$index.position" => $rooms,  
                        }
                }]
    });
    $index++;
}
$test->add_test({
        notification => $test->build_notification('attack', 'notallowed', { action => 'join' }),
        outcome => [{ type => 'log',
                    content => 
                        { '1' => 'No more players allowed' }
                }]
    });



#$test->add_test({
#    change => { 'players.0.position' => 'Kitchen' },
#    notification => $test->build_notification('attack', 'cymon', { action => 'move', destination => 'Ballroom' }),
#    outcome => [{ type => 'partial',
#                 content => { 'players.0.position' => 'Kitchen' } }]
#}); 

#my $past_ts = DateTime->now();
#$past_ts->add( hours => -2);
#$test->add_test({
#    change => { 'players.0.ongoing.timestamp' => $past_ts },
#    notification => $test->build_notification('void', 'cymon', { }),
#    outcome => [{type => 'partial',
#                content => {'players.0.position' => 'Ballroom',
#                            'players.0.ongoing' => undef } }]
#});
$test->run;




