#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'
require 'digest'
require 'zlib'

n = ARGV.shift || '10_000'
n = n.to_i
puts "#{n.to_s.reverse.scan(/\d\d?\d?/).join(',').reverse} times."

Benchmark.bm(40) do |x|
  [ 's.sum(16)',
    's.sum(32)',
    's.sum(64)',
    'Zlib.crc32(s)',
    'Digest::MD5.digest(s)',
    'Digest::RMD160.digest(s)',
    'Digest::SHA1.digest(s)',
    'Digest::SHA2.digest(s)',
    'Digest::SHA256.digest(s)',
    'Digest::SHA384.digest(s)',
    'Digest::SHA512.digest(s)',
    'Digest::SHA512.digest(s)'
  ].each do |expr|
    [ '',
      ' ' * 8,
      ' ' * 256,
      ' ' * 1024,
      ' ' * 1024 * 8
    ].each do |s|
      sz = s.length.to_s.reverse.scan(/\d\d?\d?/).join(',').reverse
      x.report(expr + "; #{sz} bytes") {
        eval %Q{
          n.times do
            #{expr}
          end
        }
      }
    end
  end
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
