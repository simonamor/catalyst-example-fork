use strict;
use warnings;

use TestFork;

my $app = TestFork->apply_default_middlewares(TestFork->psgi_app);
$app;

