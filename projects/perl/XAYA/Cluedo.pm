package XAYA::Cluedo;

use strict;
use v5.10;

use Moo;
use JSON::XS;
use DateTime;
use Data::Dumper;
extends 'XAYA::Game';

has name => (
    is => 'ro',
    default => 'Cluedo'
);

has game_status => (
    is => 'ro',
    default => sub { { players => []
                     } }
);

has rooms => (
    is => 'ro',
    default => sub { [ 'Kitchen', 'Conservatory', 'Dining Room', 'Ballroom', 'Study', 'Hall', 'Lounge', 'Library', 'Billiard Room' ] }
);
has weapons => (
    is => 'ro',
    default => sub { [ 'Candlestick', 'Dagger', 'Lead Pipe', 'Revolver', 'Rope', 'Monkey Wrench' ] }
);
has characters => (
    is => 'ro',
    default => sub { [ 'Mrs. White', 'Mr. Green', 'Mrs. Peacock', 'Professor Plum', 'Miss Scarlet', 'Colonel Mustard' ] }
);
has available_characters => (
    is => 'ro',
    default => sub { [] }
);

sub present_player
{
    my $self = shift;
    my $name = shift;
    my @player = grep {$_->{name} eq $name} @{$self->game_status->{players}};
    if(@player)
    {
        return $player[0];
    }
    else
    {
        return undef;
    }
}


sub process_notification
{
    my $self = shift;
    my $notification = shift;
    my $data = decode_json($notification->{payload});
    my $move_ok = 0;
    foreach my $move (@{$data->{moves}})
    {
        my $name = $move->{name};
        my $move = $move->{move};
        if($move->{action} eq 'join')
        {
            if(scalar @{$self->game_status->{players}} >= 6)
            {
                say "No more players allowed";
            }
            elsif($self->present_player($name))
            {
                say "Player already present"
            } 
            else
            {
                my $character =  splice @{$self->available_characters}, rand @{$self->available_characters}, 1;
                my @knowledge = @{$self->game_status->{knowledge}->{$character}};
                push @{$self->game_status->{players}}, { name => $name,
                                                         character => $character,
                                                         knowledge => \@knowledge,
                                                         position => $self->rooms->[ rand @{$self->rooms} ] };
                $move_ok = 1;
            }
        } 
        elsif($move->{action} eq 'move')
        {
            my $player = $self->present_player($name);
            if($player)
            {
                my $destination = $move->{destination};
                if($destination eq $player->{position})
                {
                    say "Bad destination"
                }
                else
                {
                    $player->{ongoing} = { move => $move, timestamp => DateTime->now };    
                    $move_ok = 1;
                }
            }
            else
            {
                say "Bad player"
            }
        }
    }
    $self->already_processed_notifications->{$notification->{topic} . $notification->{seq}} = 1;
    if($move_ok)
    {
        say Dumper($self->game_status);
    }
}

sub init
{
    my $self = shift;
    $self->SUPER::init();
    my @rooms = @{$self->rooms};
    my @weapons = @{$self->weapons};
    my @characters = @{$self->characters};
    @{$self->available_characters} = @characters;

    my $solution = {};
    my $index;

    $index = rand @rooms;
    $solution->{room} = $rooms[$index],
    splice @rooms, $index, 1;
    $index = rand @weapons;
    $solution->{weapon} = $weapons[$index],
    splice @weapons, $index, 1;
    $index = rand @characters;
    $solution->{character} = $characters[$index],
    splice @characters, $index, 1;
    $self->game_status->{solution} = $solution;

    my @clues = (@rooms, @weapons, @characters);
    for(@{$self->characters})
    {
        my $char = $_;
        my @knowledge = ();
        for(my $i = 0; $i < 3; $i++)
        {
            push @knowledge, splice( @clues, rand @clues, 1 );
        }
        $self->game_status->{knowledge}->{$char} = \@knowledge;
    }
    say Dumper($self->game_status); 

 
}

1;
