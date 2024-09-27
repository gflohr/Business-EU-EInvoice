#! /bin/false

package Business::EU::EInvoice::Command::Import; use strict;

use v5.10;

use Locale::TextDomain qw(business-eu-einvoice);

use base qw(Business::EU::EInvoice);

sub new {
	my ($class, %args) = @_;

	my $self = {};
	foreach my $arg (keys %args) {
		$self->{'__' . $arg} = $args{$arg};
	}

	bless $self, $class;
}

sub description {
	return __(<<'EOF');
import invoice data
EOF
}

sub _run {
	my ($self, $args, $global_options, %options) = @_;

	print "TODO\n";

	return $self;
}

1;

=head1 NAME

Business::EU::EInvoice::Command::Import - Import invoice data

