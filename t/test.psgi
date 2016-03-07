use strict;
use warnings;
# vim: set ft=perl;
use Plack::Builder;
use Plack::App::POD;

builder {
    mount '/pod' => Plack::App::POD->new()->to_app;
    mount '/' => sub { [ 200, [ 'Content-type' => 'text/plain' ], [ 'yarr' ] ] };
};
