#! /bin/false

package Business::EU::EInvoice; use strict;

use v5.10;

use Locale::TextDomain qw(business-eu-einvoice);

sub new {
	my ($class, $args, $global_options) = @_;

	$args ||= [];

	my %options = $class->parseOptions($args);

	my $self = {
		__args => $args,
		__global_options => $global_options,
		__options => \%options,
	};

	bless $self, $class;
}

sub name {
	my ($self) = @_;

	my $class = ref $self ? ref $self : $self;
	$class =~ s/.*:://;

	return lc $class;
}

sub description {
	my ($self) = @_;

	my $class = ref $self ? ref $self : $self;
	die __x("'{class}' does not implement the method 'description'.\n",
	        class => $class);
}

sub run {
	my ($self) = @_;

	$self->_run(
		$self->{__args},
		$self->{__global_options},
		%{$self->{__options}},
	);

	return $self;
}

sub parseOptions {
	my ($self, $args) = @_;

	my %options = $self->_getDefaults;
	my %specs = $self->_getOptionSpecs;
	$specs{help} = 'h|help';

	my %optspec;
	foreach my $key (keys %specs) {
		$optspec{$specs{$key}} =
				ref $options{$key} ? $options{$key} : \$options{$key};
	}

	Getopt::Long::Configure('bundling');
	{
		local $SIG{__WARN__} = sub {
			$SIG{__WARN__} = 'DEFAULT';
			$self->__usageError(shift);
		};

		GetOptionsFromArray($args, %optspec);
	}

	# Exits.
	$self->_displayHelp if $options{help};

	return %options;
}

sub _getDefaults {}
sub _getOptionSpecs {};

sub __usageError {
	my ($self, @msg) = @_;

	my $class = ref $self;
	$class =~ s/^Business::EU::EInvoice::Command:://;
	my $cmd = join '-', map { lcfirst $_ } split /::/, $class;

	return Business::EU::EInvoice::CLI->commandUsageError($cmd, @msg);
}

sub _displayHelp {
	my ($class) = @_;

	my $module = Business::EU::EInvoice::CLI::class2module($class);

	my $path = $INC{$module};
	$path = './' . $path if !File::Spec->file_name_is_absolute($path);

	$^W = 1 if $ENV{'PERLDOCDEBUG'};
	pop @INC if $INC[-1] eq '.';
	require Pod::Perldoc;
	local @ARGV = ($path);
	exit(Pod::Perldoc->run());
}

1;

=head1 NAME

Business::EU::EInvoice - EN16931 conforming electronic invoices

=head1 AUTHOR

P<Business::EU::EInvoice> was written by L<Guido Flohr|http://www.guido-flohr.net/>.

=head1 SEE ALSO

perl(1)
