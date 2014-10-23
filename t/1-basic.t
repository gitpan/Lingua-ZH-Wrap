#!/usr/bin/perl
# $File: //member/autrijus/Lingua-ZH-Wrap/t/1-basic.t $ $Author: autrijus $
# $Revision: #1 $ $Change: 3684 $ $DateTime: 2003/01/20 07:15:04 $

use Test;

BEGIN { plan tests => 5 }

require Lingua::ZH::Wrap;
ok($Lingua::ZH::Wrap::VERSION) if $Lingua::ZH::Wrap::VERSION or 1;

Lingua::ZH::Wrap->import(qw(wrap $columns $overflow));
$columns = 4;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i�@ �i�h �ɬO ���)));

$columns  = 3;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i �@ �i �h �� �O �� ��)));

$overflow = 1;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i�@ �i�h �ɬO ���)));

$overflow = 0;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i �@ �i �h �� �O �� ��)));

1;
