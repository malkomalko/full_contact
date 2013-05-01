package full_contact;
use Dancer ":syntax";
use JSON;
use MongoDB;
use REST::Client;

our $VERSION = "0.1";

set serializer => "JSON";

my $client = REST::Client->new();

my $mongo_client = MongoDB::MongoClient->new(
  host => "localhost", port => 27017
);
my $database = $mongo_client->get_database("full_contact");
my $collection = $database->get_collection("users");

get "/" => sub {
  template "index";
};

get "/api/1/contacts/:email" => sub {
  my $email = params->{email};
  my $api_base = "https://api.fullcontact.com/v2/";
  my $url = $api_base . "person.json?apiKey=8086e1072816dd03&email=" . $email;

  $client->GET($url, {Accept => 'application/json'});
  my $user = from_json($client->responseContent());
  $user->{"email"} = $email;

  my $cached_user = $collection->find_one({ email => $email });
  if (!$cached_user) { $collection->insert($user); }

  return $user;
};

true;
