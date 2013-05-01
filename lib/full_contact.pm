package full_contact;
use Dancer ":syntax";
use JSON;
use REST::Client;

our $VERSION = "0.1";

set serializer => "JSON";

my $client = REST::Client->new();

get "/" => sub {
  template "index";
};

get "/api/1/contacts/:email" => sub {
  my $email = params->{email};
  my $api_base = "https://api.fullcontact.com/v2/";
  my $url = $api_base . "person.json?apiKey=8086e1072816dd03&email=" . $email;

  $client->GET($url, {Accept => 'application/json'});

  return from_json($client->responseContent());
};

true;
