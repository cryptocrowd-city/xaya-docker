use strict;
use v5.10;
use JSON::RPC::Client;
use Data::Dumper;

my $method = shift;
   
my $client = new JSON::RPC::Client;
my $address = '127.0.0.1';
my $port = '18493';
  
$client->ua->credentials(
     "$address:$port", 'jsonrpc', 'user' => 'password'  # REPLACE WITH YOUR bitcoin.conf rpcuser/rpcpassword
      );
  
my $uri = "http://$address:$port/";
my $obj = {
      method  => $method,
      params  => \@ARGV,
   };

my $res = $client->call( $uri, $obj );
   
if ($res){
    if ($res->is_error) { say "Error : ", Dumper($res->error_message); }
    else { say Dumper($res->result); }
} else {
    say $client->status_line;
}
