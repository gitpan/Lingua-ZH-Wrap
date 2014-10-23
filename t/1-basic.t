#!/usr/bin/perl
# $File: //member/autrijus/Lingua-ZH-Wrap/t/1-basic.t $ $Author: autrijus $
# $Revision: #1 $ $Change: 3684 $ $DateTime: 2003/01/20 07:15:04 $

use strict;
use Test;

BEGIN { plan tests => 4 }

require Lingua::ZH::Wrap;
ok($Lingua::ZH::Wrap::VERSION) if $Lingua::ZH::Wrap::VERSION or 1;

Lingua::ZH::Wrap->import('wrap');
$Lingua::ZH::Wrap::columns = 4;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i�@ �i�h �ɬO ���)));

$Lingua::ZH::Wrap::columns  = 3;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i �@ �i �h �� �O �� ��)));

$Lingua::ZH::Wrap::overflow = 1;
ok(wrap('', '', '�i�@�i�h�ɬO���'), join("\n", qw(�i�@ �i�h �ɬO ���)));

1;
