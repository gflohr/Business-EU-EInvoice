#! /bin/false

package Business::EU::EInvoice; use strict;

use v5.10;

sub new {
	my ($class, %args) = @_;

	my $self = {};
	foreach my $arg (keys %args) {
		$self->{'__' . $arg} = $args{$arg};
	}

	bless $self, $class;
}

sub greet {
	my ($self, $name) = @_;

	$name //= 'world';

	return "Hello, $name!";
}

1;

=head1 NAME

Business::EU::EInvoice - EN16931 conforming electronic invoices

=head1 AUTHOR

P<Business::EU::EInvoice> was written by L<Guido Flohr|http://www.guido-flohr.net/>.

=head1 SEE ALSO

perl(1)
