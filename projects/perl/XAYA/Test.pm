package XAYA::Test;

use strict;
use v5.10;

use Moo;
use Data::Dumper;
use DateTime;
use JSON::XS;

has game => (
    is => 'ro'
);
has tests => (
    is => 'rw',
    default => sub { [] }
);
has notification_counter => (
    is => 'rw',
    default => 0
);

sub add_test
{
    my $self = shift;
    my $t = shift;
    push @{$self->tests}, $t;
}


sub run
{
    use Test::More;
    my $self = shift;
    $self->game->init();
    my $index = 0;
    foreach my $test (@{$self->tests})
    {
        my $label = $test->{label} ? $test->{label} : "Test $index";

        if($test->{change})
        {
            my $status = $self->game->game_status;
            foreach my $c (keys %{$test->{change}})
            {
                my @path = split /\./, $c;
                my $value = $status;
                my $index = 0;
                for(@path)
                {
                    $index++;
                    my $target = $_;
                    if($target =~ /^[0-9]+/)
                    {
                        if($index < scalar @path )
                        {
                            $value = $value->[$target] 
                        }
                        else
                        {
                            $value->[$target] = $test->{change}->{$c}
                        }
                    }
                    else
                    {
                        if($index < scalar @path )
                        {
                            $value = $value->{$target} 
                        }
                        else
                        {
                            $value->{$target}  = $test->{change}->{$c}
                        }
                    }
                    die "Wrong path $c" if ! $value;
                }
                diag($c . " changed to " . $test->{change}->{$c});
            }
        }
        if($test->{notification})
        {
            diag("New simulated notification arrived...");
            $self->game->process_notification($test->{notification});
            $self->game->clock_activities();
        }
        if($test->{outcome})
        {
            my $status = $self->game->game_status;
            if($test->{outcome}->{type} eq 'complete')
            {
                is_deeply($self->game->game_status, $test->{outcome}->{content}, 'complete status');
            }
            elsif($test->{outcome}->{type} eq 'partial')
            {
                foreach my $t (keys %{$test->{outcome}->{content}})
                {
                    my $one_of = 0;
                    my $keys = $t;
                    if($t =~ /^\?/)
                    {
                        $keys =~ s/^\?//;
                        $one_of = 1;
                    }
                    my @path = split /\./, $keys;
                    my $value = $status;
                    for(@path)
                    {
                        die "Wrong path $t" if ! $value;
                        my $target = $_;
                        if($target =~ /^[0-9]+/)
                        {
                            $value = $value->[$target] 
                        }
                        else
                        {
                            $value = $value->{$target} 
                        }
                    }
                    if($one_of)
                    {
                        ok( ( grep { $value eq $_ } @{$test->{outcome}->{content}->{$t}} ), "one of $keys")
                    }
                    elsif(! $test->{outcome}->{content}->{$t})
                    {
                        ok( ! $value, "undef $keys");
                    }
                    else
                    {
                        is_deeply($value, $test->{outcome}->{content}->{$t}, "is_deeply " . $keys);
                    } 
                }
            }
        }
        $index++;
    }
    done_testing();
}

#{
#  "block": {
#    "hash": "0cbb307d082c3b1804b265b71e27e061e6b5436afedc53c13d03221421f53c97",
#    "parent": "99265ac4578d9f2affcdb5dfb25bc5585f2806494383690fd2f6596552e30a23",
#    "height": 106,
#    "timestamp": 1566827264,
#    "rngseed": "0feedc8ffaf74646ccc4ba6eece2b4d191e05714c617d6c2be572260abe1f266"
#  },
#  "moves": [
#    {
#      "txid": "6b996f6d8cffab3977611a9456903ec71324b5734dbf7707b8eca5e931642e01",
#      "name": "cymon",
#      "inputs": [
#        {
#          "txid": "4e51e321a3bfa790ac257dd53c26720282453cadfda26fc10186e3c0dea036cd",
#          "vout": 1
#        },
#        {
#          "txid": "4e51e321a3bfa790ac257dd53c26720282453cadfda26fc10186e3c0dea036cd",
#          "vout": 0
#        }
#      ],
#      "out": {
#        "cYRqhURiGkwswKXTD5Eac5w5kQAerWbBYC": 49.989348
#      },
#      "move": {
#        "m": "Hello"
#      }
#    }
#  ],
#  "admin": []
#}

sub build_notification
{
    my $self = shift;
    my $action = shift;
    my $player = shift;
    my $move = shift;

    my $topic = "game-block-$action json " . $self->game->name;
    my $payload = {
        block => {
            hash => "XXXXX",
            parent => "XXXXX",
            heigth => $self->notification_counter,
            timestamp => DateTime->now->epoch,
            rgnseed => "XXXXX", 
        },
        moves => [ 
            {
                "txid" => 'XXXXX',
                "name" => $player,
                "inputs" => [{ txid => 'XXXXX', "vout" => 1}, { txid => 'XXXXX', "vout" => 0}],
                "out" => { "XXXXX" => 50 },
                "move" => $move
            }
        ]
    };
    my $seq = $self->notification_counter;
    $self->notification_counter($self->notification_counter + 1);    
    return { topic => $topic,
             payload => encode_json($payload),
             seq => $seq };
}

1;






