use strict;
use v5.10;

use Test::More tests => 3;

use_ok 'Business::EU::EInvoice', 'module loads';

my $instance = Business::EU::EInvoice->new;

ok $instance, 'instantiated';
is $instance->greet('Jane Appleseed'), 'Hello, Jane Appleseed!', 'greeting';
