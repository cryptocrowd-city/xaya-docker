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

say "Inspect test";
$test->add_test({
    label => "Adding first player",
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
    label => "Adding second player",
    notification => $test->build_notification('attack', 'second', { action => 'join' }),
    outcome => [{ type => 'partial',
                 content => 
                    { 'players.1.name' => 'second',
                      '?players.1.character' => $characters,  
                      '?players.1.position' => $rooms,  
                    }
               }]
});
$test->add_test({
    label => "First player inspects",
    change => { 'players.0.position' => 'Kitchen',
                'players.1.position' => 'Kitchen' }, 
    notification => $test->build_notification('attack', 'cymon', { action => 'inspect' }),
    outcome => [{ type => 'partial',
                 content => { 'players.0.ongoing.move.action' => 'inspect' }
               }]
});
$test->add_test({
    label => "First player inspects again but he's busy",
    change => { 'players.0.position' => 'Kitchen',
                'players.1.position' => 'Kitchen' }, 
    notification => $test->build_notification('attack', 'cymon', { action => 'inspect' }),
    outcome => [{ type => 'log',
                 content => { '0' => 'Busy player' } }]
});
$test->add_test({
    label => "Second player inspects but first player is already inspecting here",
    change => { 'players.0.position' => 'Kitchen',
                'players.1.position' => 'Kitchen' }, 
    notification => $test->build_notification('attack', 'second', { action => 'inspect' }),
    outcome => [{ type => 'log',
                 content => { '1' => 'not available for inspection' } }]
});
my $past_ts = DateTime->now();
$past_ts->add( hours => -2);
$test->add_test({
    label => "Inspect action executed",
    change => { 'players.0.ongoing.timestamp' => $past_ts },
    notification => $test->build_notification('void', 'cymon', { }),
    outcome => [{type => 'partial',
                content => {'players.0.ongoing' => undef } }]
});
$test->add_test({
    label => "Second player inspects again but room can't be inspected yet",
    change => { 'players.0.position' => 'Kitchen',
                'players.1.position' => 'Kitchen' }, 
    notification => $test->build_notification('attack', 'second', { action => 'inspect' }),
    outcome => [{ type => 'log',
                 content => { '1' => 'not available for inspection' } }]
});
$test->run();
