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

say "Move test";
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
    notification => $test->build_notification('attack', 'wrong', { action => 'move', destination => 'Ballroom' }),
    outcome => [{ type => 'log',
                 content => { '0' => 'Bad player' } }]
}); 
$test->add_test({
    change => { 'players.0.position' => 'Kitchen' },
    notification => $test->build_notification('attack', 'cymon', { action => 'move', destination => 'Kitchen' }),
    outcome => [{ type => 'log',
                 content => { '1' => 'Bad destination' } }]
}); 
$test->add_test({
    notification => $test->build_notification('attack', 'cymon', { action => 'move', destination => 'Away' }),
    outcome => [{ type => 'log',
                 content => { '2' => 'Wrong destination' } }]
}); 
$test->add_test({
    change => { 'players.0.position' => 'Kitchen' },
    notification => $test->build_notification('attack', 'cymon', { action => 'move', destination => 'Ballroom' }),
    outcome => [{ type => 'partial',
                 content => { 'players.0.position' => 'Kitchen' } }]
}); 
$test->add_test({
    change => { 'players.0.position' => 'Kitchen' },
    notification => $test->build_notification('attack', 'cymon', { action => 'move', destination => 'Study' }),
    outcome => [{ type => 'log',
                 content => { '3' => 'Busy player' } }]
}); 

my $past_ts = DateTime->now();
$past_ts->add( hours => -2);
$test->add_test({
    change => { 'players.0.ongoing.timestamp' => $past_ts },
    notification => $test->build_notification('void', 'cymon', { }),
    outcome => [{type => 'partial',
                content => {'players.0.position' => 'Ballroom',
                            'players.0.ongoing' => undef } }]
});
$test->run();
