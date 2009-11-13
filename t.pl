#!/usr/bin/perl

use warnings;
use strict;

# use Finance::Card::Citibank;
# 
# # Create client with ordered list of arguements
# my @accounts = Finance::Card::Citibank->check_balance(
#                 content => 'out.html',
# 		 );
# 
# for (@accounts){
# 	printf "# %18s : %8s / %8s : \$ %9.2f\n",
# 	    $_->name, $_->sort_code, $_->account_no, $_->balance;
# }
# 

use Data::Dumper;

open(F,"<out.html"); 
my $x= do { local $/; <F>; };
close F;

# use Text::Balanced qw( gen_extract_tagged );
# my $extract_div = gen_extract_tagged('<div class="main_module">','</div>');
# my ($e,$r) = $extract_div->($x);
# print Dumper [ $e ];

# div.main_module>span.card_num
# div.main_module>div.curr_balance
use HTML::TreeBuilder::XPath;
use HTML::Element;
my $tree = HTML::TreeBuilder::XPath->new;
$tree->parse_content( $x ) or die;
my @a = $tree->findnodes( '//div[@class="main_module"]' );
for (@a){
    print ">\n";
    my $tree = HTML::TreeBuilder::XPath->new;
    # print $_->as_HTML( undef, "  " );
    $tree->parse_content( $_->as_HTML ) or die;
    print $_->as_trimmed_text . "\n" for $tree->findnodes( '//span[@class="card_num"]' );
    print $_->as_trimmed_text . "\n" for $tree->findnodes( '//div[@class="curr_balance"]' );
}

# my @a = $tree->findnodes( '//div[@class="main_module"]' );
# for my $n (@a){
#     print ">" . $_->as_HTML for $n->findnodes( '//span[@class="card_num"]' );
#     # $_->findvalue( '/div[@class="curr_balance"]' ),
# }
# print Dumper \@a;

__END__
print $_->xpath_to_literal for @a;
my @b = $tree->findnodes( '//div[@class="curr_balance"]' );
print $_->xpath_to_literal for @b;

__END__
# use re 'debug';
my @accnts = $x =~ m!
          <span\sclass="prodName"><a\sname="View(\d+)c"></a>(.*?)</span></td>\s*
          </tr>\s*
          <tr>\s*
          <td>&nbsp;(Account\sending\sin:\s*\d+)</td>\s*
          .*?
          Current\sBalance.*?
          </tr>\s*
          <tr>\s*
          <td\s[^>]*><div[^>]*><span\sclass="balNdue">\$([\d,\.]+)</span></div></td>
     !xisg;

print "Accounts:\n";
print join "\n", @accnts, "\n";
