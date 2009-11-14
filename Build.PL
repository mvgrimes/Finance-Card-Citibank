use Module::Build;

my $build = Module::Build->new(
    module_name   => 'Finance::Card::Citibank',
    license       => 'perl',
    create_readme => 1,
    ## create_makefile_pl => 'passthrough',
    requires => {
        'Carp'                     => 0,
        'WWW::Mechanize'           => 1.00,
        'Crypt::SSLeay'            => 0,
        'Class::Accessor::Fast'    => 0,
        'HTML::TreeBuilder::XPath' => 0,
        'HTML::Element'            => 0,
    },
    build_requires => {
        'Test::More' => 0,
        'File::Spec' => 0,
    },
    add_to_cleanup => [ 'Finance-Card-Citibank-*', 'Debian_CPANTS.txt' ],
    meta_merge     => {
        resources => {
            bugtracker =>
              'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Finance-Card-Citibank',
            repository => 'http//github.com/mvgrimes/Finance-Card-Citibank',
        }
    },
);
$build->create_build_script;

