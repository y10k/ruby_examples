#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'

class Integer
  def to_comma
    to_s.reverse.scan(/\d\d?\d?/).join(',').reverse
  end
end

n = 100
blksiz = 1028 * 8
blkdat = "x" * blksiz

def open_test_file
  File.open('io_test.dat', 'wb:ascii-8bit') {|output|
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

  open_test_file{|f|
    f.truncate(blksiz * n)
    f.fsync

    x.report('[fixed file size] fsync') {
      n.times do
        f.write(blkdat)
        f.fsync
      end
    }
  }

  open_test_file{|f|
    f.truncate(blksiz * n)
    f.fsync

    x.report('[fixed file size] fdatasync') {
      n.times do
        f.write(blkdat)
        f.fdatasync
      end
    }
  }
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
