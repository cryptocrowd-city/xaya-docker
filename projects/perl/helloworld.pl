use strict;
use v5.10;
use JSON::XS;
use JSON::RPC::Client;
use ZMQ::LibZMQ3;
use ZMQ::Constants ':all'; 
use Data::Dumper;

my $GAME_NAME = 'HelloPerl';


rpc_call("trackedgames", "add", $GAME_NAME);
my $subscriber = init_subscriber();

my @fragments;
my $buffer;
my %already = ();

my @game_status = ();

while (1) {
    $buffer = zmq_recvmsg($subscriber);
    my $size = zmq_msg_size($buffer);
    my $fragment = zmq_msg_data($buffer);
    push @fragments, $fragment;
    if(! zmq_getsockopt($subscriber, ZMQ_RCVMORE))
    {
        my $cursor = 0;
        while($cursor < scalar @fragments)
        {
            my $notification = {};
            $notification->{topic} = $fragments[$cursor++];
            $notification->{payload} = $fragments[$cursor++];
            $notification->{seq} = unpack("v*", $fragments[$cursor++]);

            if(notification_to_process($notification))
            {
                my $data = decode_json($notification->{payload});
                for(@{$data->{moves}})
                {
                    my $move = { name => $_->{name}, message => $_->{move}->{m} };
                    push @game_status, $move;
                    say $move->{name} . " says " . $move->{message};
                    $already{$notification->{topic} . $notification->{seq}} = 1;
                }
            }
        }
    }
}



sub notification_to_process
{
    my $n = shift;
    if($n->{topic} !~ /$GAME_NAME$/)
    {
        return 0;
    }
    elsif(exists $already{$n->{topic} . $n->{seq}})
    {
        return 0;
    }
    return 1;
}

sub init_subscriber
{
    my $ctxt = zmq_init;
    my $subscriber = zmq_socket( $ctxt, ZMQ_SUB);
    zmq_setsockopt($subscriber, ZMQ_IDENTITY, 'helloworld_perl');
    zmq_setsockopt($subscriber, ZMQ_SUBSCRIBE, 'game');
    my $rv = zmq_connect( $subscriber, "tcp://127.0.0.1:28332" );
    return $subscriber;
}

sub rpc_call
{
    my $method = shift;
    my @arguments = @_;
   
    my $client = new JSON::RPC::Client;
    my $address = '127.0.0.1';
    my $port = '18493';
  
    $client->ua->credentials(
        "$address:$port", 'jsonrpc', 'user' => 'password'  # REPLACE WITH YOUR bitcoin.conf rpcuser/rpcpassword
    );
  
    my $uri = "http://$address:$port/";
    my $obj = {
        method  => $method,
        params  => \@arguments,
    };
    my $res = $client->call( $uri, $obj );
   
    if ($res){
        if ($res->is_error) { say "Error : ", Dumper($res->error_message);
            say $method . " - " . join(" ", @ARGV);
         }
        else { 
        }
    } else {
        say $client->status_line;
    }
}




