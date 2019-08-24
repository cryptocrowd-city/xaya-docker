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
zmq_setsockopt($subscriber, ZMQ_IDENTITY, 'Differentme');
zmq_setsockopt($subscriber, ZMQ_SUBSCRIBE, 'game');
my $rv = zmq_connect( $subscriber, "tcp://127.0.0.1:28332" );
my $sync =  zmq_socket( $ctxt, ZMQ_PUSH);
$rv = zmq_connect( $sync, "tcp://127.0.0.1:28332" );
$rv = zmq_msg_send('', $sync);
my $parts = 0;
my $multipart = {};
my @fragments;
my $counter = 0;
my %already;
while (1) {
    my $buffer;
    $buffer = zmq_recvmsg($subscriber);
    my $size = zmq_msg_size($buffer);
    my $fragment = zmq_msg_data($buffer);
    push @fragments, $fragment;
    if(zmq_getsockopt($subscriber, ZMQ_RCVMORE))
    {
    }
    else
    {
        my $printout = "";
        my $topic = "";
        my $seq = -1;
        my $print_next = 0;
        my $printed = 0;
        my $skipped = 0;
        open(my $fh, "> out.$counter");
        foreach my $f (@fragments)
        {
            if($f =~ /^game/)
            {
                $topic = $f;
                $printout .= "Topic: " . $f . "\n";
                $print_next = 1;
            }
            elsif($print_next == 1)
            {
                $printout .= "Payload: " . $f . "\n";
                $print_next = 2;
            }
            elsif($print_next == 2)
            {
                $seq =   unpack("v*", $f);
                $printout .= "Seq: $seq\n";
                if(! exists $already{$topic.$seq})
                {
                    print {$fh} $printout;
                    $already{$topic.$seq} = 1;
                    $printed++;
                }
                else
                {
                    $skipped++;
                }
                $printout = "";
                $print_next = 0;
            }
            else
            {
            }
        }
        close($fh);
        say "output recorded: out.$counter ($printed/$skipped)";
        $counter++;
    }
#
#
#
#    if($parts == 0)
#    {
#        #say "Payload: " . unpack("H*", $data) . " (size: $size)";
#        #say "Payload: " . $data . " (size: $size)";
#        $multipart->{'payload'} = $data;
#        $multipart->{'payload-size'} = $size;
#        $parts++;
#    }
#    elsif($parts == 1)
#    {
#       #say "Topic: " . $data . " (size: $size)";
#       #say "Topic detected: $data";
#       $multipart->{'topic'} = $data;
#       $multipart->{'topic-size'} = $size;
#       $parts++;
#    }
#    elsif($parts == 2)
#    {
#        #say "Seq: "  . unpack("v*", $data) . " (size: $size)";
#        $multipart->{'seq'} = $data;
#        $multipart->{'seq-size'} = $size;
#        $parts = 0;
#        print_notification($multipart);
#        $multipart = {};
#    }
}

sub print_notification
{
    my $n = shift;
    if($n->{'topic'} =~ /game/)
    {
        say "===";
        say "Topic: " . $n->{'topic'};
        say "Payload: " . $n->{'payload'};
        say "Seq: " . unpack("v", $n->{'seq'});
        say "More: " . $n->{more};
        say "===";
    }
    else    
    {
        say $n->{topic} . " skipped";
    }


}

