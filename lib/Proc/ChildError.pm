package Proc::ChildError;

use 5.010001;
require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(explain_child_error);

our $VERSION = '0.01'; # VERSION

sub explain_child_error {
    my ($num, $str);
    if (defined $_[0]) {
        $num = $_[0];
        $str = $_[1];
    } else {
        $num = $?;
        $str = $!;
    }

    if ($num == -1) {
        return "failed to execute: ".($str ? "$str ":"")."($num)";
    } elsif ($num & 127) {
        return sprintf(
            "died with signal %d, %s coredump",
            ($num & 127),
            (($num & 128) ? 'with' : 'without'));
    } else {
        return sprintf("exited with code %d", $num >> 8);
    }
}

1;
# ABSTRACT: Explain process child error

__END__

=pod

=encoding UTF-8

=head1 NAME

Proc::ChildError - Explain process child error

=head1 VERSION

version 0.01

=head1 FUNCTIONS

=head2 explain_child_error($child_error, $os_error) => STR

Produce a string description of an error number. C<$child_error> defaults to
C<$?> if not specified. C<$os_error> defaults to C<$!> if not specified.

The algorithm is taken from perldoc -f system. Some sample output:

 failed to execute: No such file or directory (-1)
 died with signal 15, with coredump
 exited with value 3

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Proc-ChildError>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Proc-ChildError>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Proc-ChildError>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
