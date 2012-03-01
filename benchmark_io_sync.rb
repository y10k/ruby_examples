#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'

class Integer
  def to_comma
    to_s.reverse.scan(/\d\d?\d?/).join(',').reverse
  end
end

n = Integer(ARGV.shift || 100)
blksiz = Integer(ARGV.shift || 1028 * 8)
blkdat = "x" * blksiz

puts "#{n.to_comma} times."
puts "block size: #{blksiz.to_comma} bytes"
puts "total data size: #{(blksiz * n).to_comma} bytes"

def open_test_file(flags=nil)
  mode = File::WRONLY | File::CREAT | File::TRUNC
  mode |= flags if flags
  File.open('io_test.dat', mode) {|output|
    output.binmode
    output.set_encoding(Encoding::ASCII_8BIT)
    yield(output)
  }
end

Benchmark.bm(30) do |x|
  x.report('empty') {
    n.times do
    end
  }

  open_test_file{|f|
    x.report('no sync') {
      n.times do
        f.write(blkdat)
      end
    }
  }

  open_test_file{|f|
    x.report('fsync once') {
      n.times do
        f.write(blkdat)
      end
      f.fsync
    }
  }

  open_test_file{|f|
    x.report('fdatasync once') {
      n.times do
        f.write(blkdat)
      end
      f.fdatasync
    }
  }

  open_test_file{|f|
    x.report('fsync') {
      n.times do
        f.write(blkdat)
        f.fsync
      end
    }
  }

  open_test_file{|f|
    x.report('fdatasync') {
      n.times do
        f.write(blkdat)
        f.fdatasync
      end
    }
  }

  open_test_file(File::SYNC) {|f|
    x.report('open SYNC') {
      n.times do
        f.write(blkdat)
      end
    }
  }

  open_test_file(File::DSYNC) {|f|
    x.report('open DSYNC') {
      n.times do
        f.write(blkdat)
      end
    }
  }

  open_test_file{|f|
    f.write(blksiz * n)
    f.rewind
    f.fsync

    x.report('[fixed file size] fsync') {
      n.times do
        f.write(blkdat)
        f.fsync
      end
    }
  }

  open_test_file{|f|
    f.write(blksiz * n)
    f.rewind
    f.fsync

    x.report('[fixed file size] fdatasync') {
      n.times do
        f.write(blkdat)
        f.fdatasync
      end
    }
  }

  open_test_file(File::SYNC) {|f|
    f.write(blksiz * n)
    f.rewind
    f.fsync

    x.report('[fixed file size] open SYNC') {
      n.times do
        f.write(blkdat)
      end
    }
  }

  open_test_file(File::DSYNC) {|f|
    f.write(blksiz * n)
    f.rewind
    f.fsync

    x.report('[fixed file size] open DSYNC') {
      n.times do
        f.write(blkdat)
      end
    }
  }
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
