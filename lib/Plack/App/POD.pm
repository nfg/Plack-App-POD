package Plack::App::POD;

use strict;
use 5.008_005;
our $VERSION = '0.01';

# Note to self: Same idea as Mojolicious::Plugin::PODRenderer, which is awesome.
# Use Pod::Simple::XHTML to generate markup, serve as a page.
# Should be mountable like
#       mount '/pod' => Plack::App::POD->new()->to_app;

1;
__END__

=encoding utf-8

=head1 NAME

Plack::App::POD - Blah blah blah

=head1 SYNOPSIS

  use Plack::App::POD;

=head1 DESCRIPTION

Plack::App::POD is

=head1 AUTHOR

Nigel Gregoire E<lt>nigelgregoire@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2016- Nigel Gregoire

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
