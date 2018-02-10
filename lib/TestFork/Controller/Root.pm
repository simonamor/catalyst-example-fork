package TestFork::Controller::Root;
use Moose;
use namespace::autoclean;

use POSIX qw(setsid);

use LWP::UserAgent;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

TestFork::Controller::Root - Root Controller for TestFork

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->redirect($c->uri_for("/profile"));

    if (fork() == 0) {

        # if fork() returns 0, it's the child process

        close(STDOUT);
        close(STDERR);
        close(STDIN);

        POSIX::setsid();

        # The child process
        my $ua = LWP::UserAgent->new();
        $ua->get( $c->uri_for("/fork/whoa") );

        exit;
    }
    sleep(1);
}

sub profile :Path("/profile") :Args(0) {
    my ($self, $c) = @_;

    my $dumb = $c->model('Dumb');
    warn "lock status is...\n";
    warn $dumb->locked;
    warn "so there.\n";

    $c->log->debug("Locked status is " . $dumb->locked);
    if ($dumb->locked) {
        $c->response->body("<html><head></head><body><a href='/profile'>Locked... reload</a></body></html>");
    } else {
        $c->response->body("<html><head></head><body>Everything is good.</body></html>");
    }
}

sub fork :Path("/fork") :Args(1) {
    my ($self, $c, $f) = @_;

    warn ("Starting a request for $f " . scalar(localtime(time)));
    $c->model('Dumb')->set_lock();
    sleep(2);
    warn("Middle of request for $f " . scalar(localtime(time)));
    sleep(2);
    warn("Middle of request for $f " . scalar(localtime(time)));
    sleep(2);
    warn("Middle of request for $f " . scalar(localtime(time)));
    sleep(2);
    warn("Middle of request for $f " . scalar(localtime(time)));
    sleep(2);
    warn("Ending a request for $f " . scalar(localtime(time)));
    $c->response->body("Have a $f");
    $c->model('Dumb')->clear_lock();
}


=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
