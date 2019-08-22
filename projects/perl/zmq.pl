use strict;
use v5.10;
use ZMQ::LibZMQ3;
use strict;
use v5.10;
use ZMQ::Constants ':all'; 
use Encode qw( decode_utf8 );
use Data::Dumper;
#use FFI::Platypus;
#use FFI::Platypus::Memory qw( malloc );
#use FFI::Platypus::Buffer qw( scalar_to_buffer buffer_to_scalar );

my $socket;
my $ctxt = zmq_init;
my $subscriber = zmq_socket( $ctxt, ZMQ_SUB);
zmq_setsockopt($subscriber, ZMQ_IDENTITY, 'Hello');
zmq_setsockopt($subscriber, ZMQ_SUBSCRIBE, '');
my $rv = zmq_connect( $subscriber, "tcp://127.0.0.1:28332" );
my $sync =  zmq_socket( $ctxt, ZMQ_PUSH);
$rv = zmq_connect( $sync, "tcp://127.0.0.1:28332" );
$rv = zmq_msg_send('', $sync);
my $parts = 0;
while (1) {
    my $buffer;
    $rv = zmq_recv($subscriber, $buffer, 800);
    $buffer = zmq_recvmsg($subscriber);
    my $size = zmq_msg_size($buffer);
    my $data = zmq_msg_data($buffer);
    if($parts == 0)
    {
        say "==START==";
        say "Payload: " . unpack("H*", $data) . " (size: $size)";
        $parts++;
    }
    elsif($parts == 1)
    {
       say "Topic: " . $data . " (size: $size)";
       $parts++;
    }
    elsif($parts == 2)
    {
        say "Seq: "  . unpack("v*", $data) . " (size: $size)";
       $parts = 0;
        say "===END===";
    }
}


