# $File: //member/autrijus/Lingua-ZH-Wrap/Wrap.pm $ $Author: autrijus $
# $Revision: #1 $ $Change: 3684 $ $DateTime: 2003/01/20 07:15:04 $

package Lingua::ZH::Wrap;
$Lingua::ZH::Wrap::VERSION = '0.01';

use strict;
use vars qw($VERSION @ISA @EXPORT $columns $overflow);

use Exporter;

=head1 NAME

Lingua::ZH::Wrap - Wrap Chinese text

=head1 SYNOPSIS

=head2 Example 1

    use Lingua::ZH::Wrap;

    $initial_tab = "\t";	# Tab before first line
    $subsequent_tab = "";	# All other lines flush left

    print wrap( $initial_tab, $subsequent_tab, @lines );

=head2 Example 2

    use Lingua::ZH::Wrap qw(wrap $columns $overflow);

    $columns  = 75;		# Change columns
    $overflow = 1;		# Chinese char may occupy 76th col

    print wrap( '', '', @lines );

=head1 DESCRIPTION

C<Lingua::ZH::Wrap::wrap()> is a very simple paragraph formatter.
It formats a single paragraph at a time by breaking lines at Chinese
characterboundries.

Indentation is controlled for the first line (C<$initial_tab>) and
all subsequent lines (C<$subsequent_tab>) independently.  Please note: 
C<$initial_tab> and C<$subsequent_tab> are the literal strings that will
be used: it is unlikely you would want to pass in a number.

=head1 OVERRIDES

C<Lingua::ZH::Wrap::wrap()> has a number of variables that control its
behavior.

Lines are wrapped at C<$Lingua::ZH::Wrap::columns> columns; if a Chinese
character just extends columns by one byte, it will be wrapped into the
next line, unless C<$Lingua::ZH::Wrap::overflow> is set to a true value.

=head1 CAVEATS

The algorithm doesn't care about breaking non-Chinese words.  Also,
Unicode handling is not there -- you have to pass in strings encoded
in C<Big5>, C<GBK>, or other double-byte coding systems.

Patches are, of course, very welcome; in particular, I'd like to use
L<Lingua::ZH::TaBE> to avoid beginning-of-line punctuations, as well
as employing other semantic-sensitive formatting techniques.

=cut

@ISA      = qw(Exporter);
@EXPORT   = qw(wrap);
$columns  = 72;
$overflow = 0;

sub wrap {
    my ($init, $subs) = (shift, shift);

    return join("\n", map(wrap($init, $subs, $_), @_)) if @_ > 1;

    my $str = shift;
    return join("\n", map(wrap($init, $subs, $_), split("\n", $str)))
        if (index($str, "\n") > -1); # Handles single-line only

    my ($fin, $pos) = ($columns - 1, 0);

    $str = "$init$str";

    do {
        $str =~ m/\G.{0,$fin}[\x00-\x7f]/go;
        $pos += $columns + (((pos($str) ||= $pos) + $pos + $columns) % 2)
            * (!!$overflow * 2 - 1);
        return $str if $pos >= length($str);
        substr($str, $pos, 0, "\n$subs");
    } while (pos($str) = ++$pos);

    return $str;
}

1;

=head1 SEE ALSO

L<Text::Wrap>

=head1 AUTHORS

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 COPYRIGHT

Copyright 2003 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
