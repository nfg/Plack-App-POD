package Plack::App::POD;

use strict;
use 5.008_005;
our $VERSION = '0.01';

use Plack::Component;
use parent qw(Plack::Component);

use Plack::Util;
use Plack::Util::Accessor qw(parser);
use Pod::Simple::XHTML;
use Data::Printer;

sub call {
    my ($self, $env) = @_;

    p $env;

    my $filename = $env->{PATH_INFO};
    $filename =~ s{^/}{};
    $filename =~ s{/$}{};
    $filename =~ s{::}{/}g;
    $filename .= '.pm';

    my $output;
    foreach my $dir (@INC) {
        my $path = $dir . '/' . $filename;
        print "Checking $path\n";
        next unless -e $path;
        my $parser = Plack::App::POD::Parser->new();
        $parser->perldoc_url_prefix($env->{SCRIPT_NAME} . '/');
        $parser->html_header_tags(<<EOBOOT

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
EOBOOT
        );

        $parser->output_string(\$output);
        $parser->parse_file($path);

        return [ 200, [ 'Content-type' => 'text/html' ], [ $output ] ];
    }

    return [ 404, [ 'Content-type' => 'text/plain' ], [ 'not found' ] ];
};

package Plack::App::POD::Parser;

use parent qw(Pod::Simple::XHTML);

sub parse_file
{
    my $self = shift;
    my $html_header_tags = $self->html_header_tags;
    $html_header_tags = '' if ! defined $html_header_tags;
    $html_header_tags .= qq(
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
        );

    $self->SUPER::parse_file(@_);

    ${$self->output_string} =~ s/<head>/<head>\n<meta charset="utf-8">\n<meta http-equiv="X-UA-Compatible" content="IE=edge">\n<meta name="viewport" content="width=device-width, initial-scale=1">\n/s;

    my $navbar = <<EOHTML;
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>
<div class="container">
<br/><br/><br/><br/>
EOHTML

    ${$self->output_string} =~ s/(<body[^>]*>)/$1$navbar/;
    ${$self->output_string} =~ s{</body>}{</div></body>};

    
#    <head>/<head>\n<meta charset="utf-8">\n<meta http-equiv="X-UA-Compatible" content="IE=edge">\n<meta name="viewport" content="width=device-width, initial-scale=1">\n/s;

    return;
}


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

__DATA__

yarr
