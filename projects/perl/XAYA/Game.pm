package XAYA::Game;

use strict;
use v5.10;

use Moo;
use JSON::XS;
use JSON::RPC::Client;
use ZMQ::LibZMQ3;
use ZMQ::Constants ':all'; 
use Data::Dumper;

has name => (
    is => 'ro',
);

# ZMQ Management
has zmq_endpoint => (
    is => 'ro',
    default => 'tcp://127.0.0.1:28332'
);
has subscriber => (
    is => 'rw'
);
has already_processed_notifications => (
    is => 'ro',
    default => sub { {} }
);
has test => (
    is => 'ro',
    default => 0
);

#XAYA RPC Management
has xaya_rpc_endpoint => (
    is => 'ro',
    default => sub { { protocol => 'http',
                       address => '127.0.0.1',
                       port => '18493',
                       user => 'user',
                       password => 'password' } }

);

#Game status API (not implemented yet)
has game_rpc_port => (
    is => 'ro',
    default => 29050
);
has game_status => (
    is => 'ro',
    default => sub { {} }
);

sub notification_to_process
{
    my $self = shift;
    my $n = shift;
    my $name = $self->name;
    if($n->{topic} !~ /$name$/)
    {
        return 0;
    }
    elsif(exists $self->already_processed_notifications->{$n->{topic} . $n->{seq}})
    {
        return 0;
    }
    return 1;
}

sub init_subscriber
{
    my $self = shift;
    my $ctxt = zmq_init;
    my $subscriber = zmq_socket( $ctxt, ZMQ_SUB);
    zmq_setsockopt($subscriber, ZMQ_IDENTITY, $self->name);
    zmq_setsockopt($subscriber, ZMQ_SUBSCRIBE, 'game');
    my $rv = zmq_connect( $subscriber, $self->zmq_endpoint );
    $self->subscriber($subscriber);
}

sub fetch_notifications
{
    my $self = shift;

    my @fragments = ();
    my @out = ();
    do {
        my $buffer = zmq_recvmsg($self->subscriber);
        my $fragment = zmq_msg_data($buffer);
        push @fragments, $fragment;
    }
    while(zmq_getsockopt($self->subscriber, ZMQ_RCVMORE));

    my $cursor = 0;
    while($cursor < scalar @fragments)
    {
        my $notification = {};
        $notification->{topic} = $fragments[$cursor++];
        $notification->{payload} = $fragments[$cursor++];
        $notification->{seq} = unpack("v*", $fragments[$cursor++]);

        push @out, $notification if($self->notification_to_process($notification));
    }
    return @out;
}

sub process_notification
{
    my $self = shift;
    my $notification = shift;
    my $data = decode_json($notification->{payload});
    for(@{$data->{moves}})
    {
        my $move = { name => $_->{name}, message => $_->{move}->{m} };
                    #push @$self->game_status->{moves}}, $move;
        say $move->{name} . " says " . $move->{message};
    }
    $self->already_processed_notifications->{$notification->{topic} . $notification->{seq}} = 1;
}

sub rpc_call
{
    my $self = shift;
    my $method = shift;
    my @arguments = @_;
   
    my $client = new JSON::RPC::Client;
    my $protocol = $self->xaya_rpc_endpoint->{protocol};
    my $address = $self->xaya_rpc_endpoint->{address};
    my $port = $self->xaya_rpc_endpoint->{port};
  
    $client->ua->credentials(
        "$address:$port", 'jsonrpc', $self->xaya_rpc_endpoint->{user} => $self->xaya_rpc_endpoint->{password}
    );
  
    my $uri = "$protocol://$address:$port/";
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

sub init
{
    my $self = shift;
    if(! $self->test)
    {
        $self->rpc_call("trackedgames", "add", $self->name);
        $self->init_subscriber();
    }
}

sub main_loop
{
    my $self = shift;

    while (1) {
        my @notifications = $self->fetch_notifications();
        foreach my $n (@notifications)
        {
            $self->process_notification($n);
        }
    }
}

sub start
{
    my $self = shift;
    $self->init();
    $self->main_loop();
}

1;


