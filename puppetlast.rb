#!/usr/bin/env ruby
# $Id: puppetlast.rb 1599 2012-05-11 14:00:48Z rixona $
#
# Script:	puppetlast.rb
#
# Description:	Replacement for puppetlast in puppet-0.25
# 		Ruby rewrite of https://github.com/gregarmer/puppetlast
#		Run on Puppet master
#
# Requires:	puppet
#
# Author:	Ade Rixon, eLINIA
#
# History:
#	20120511: Created - ajr
#

INTERVAL = 30	# between puppet agent runs

now = Time.now
times = []
# check timestamps of node fact files on master
Dir['/var/lib/puppet/yaml/facts/*.yaml'].each do |f|
  host=File.basename(f.sub(/\.yaml$/, ''))
#  puts host	# DEBUG
  last = now - File.mtime(f)	# age of file
  times.push([(last.to_i / 60), host, last.to_i])
end

if STDOUT.tty?
  # ANSI colours for tty output
  RED = "\033[91m"
  GREEN = "\033[92m"
  RESET = "\033[0m"
else
  # otherwise text symbol for pipeline processing
  RED = '*'
  GREEN = ' '
  RESET = ''
end

times.sort! {|a,b| a[2] <=> b[2]}	# sort by ascending time of run
times.each do |entry|
  printf("%s %10d mins ago: %s %s\n", (entry[0] <= INTERVAL) ? GREEN : RED, entry[0], entry[1], RESET)
end
