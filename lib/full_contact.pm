package full_contact;
use Dancer ":syntax";
use REST::Client;

our $VERSION = "0.1";

set serializer => "JSON";

get "/" => sub {
  template "index";
};

get "/api/1/contacts/:email" => sub {
  my $email = params->{email};

  return {
    "contactInfo" => {
      "fullName" => "Robert Malko"
    },
    "likelihood" => 0.98,
    "photos" => [{
      "url" => "https://d2ojpxxtu63wzl.cloudfront.net/static/3b24fde6c57032061d59251280f5007f_b1c4baf6b5b9fa06a10ed26efc80b2e83e7446989de2e2b59e00e0cb558d629d"
    }]
  };
};

true;
