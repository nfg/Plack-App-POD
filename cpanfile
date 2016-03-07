requires 'perl', '5.008005';

requires 'Plack';
requires 'Pod::Simple::XHTML';

on test => sub {
    requires 'Test::More', '0.96';
    requires 'Test::Warnings';
    requires 'Test::Deep';
};
