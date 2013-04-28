package full_contact;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
  template 'index';
};

true;
