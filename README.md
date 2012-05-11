# Summary

`puppetlast.rb` is a straight rewrite of
<http://github.com/gregarmer/puppetlast> in Ruby, which itself was a
replacement for the puppetlast utility originally shipped with Puppet
0.25 and removed since 2.6. It displays the last connect time of all
Puppet agents to the master, with those connecting over 30 mins ago (and
therefore likely to have stopped running regularly) highlighted.

Note that puppetlast.rb is not as comprehensive or intelligent as the
original puppetlast script (doesn't check cache expiry or use the Puppet
API). It assumes the default location for your client YAML files.

# Support

Write a better one, you have my full endorsement.
