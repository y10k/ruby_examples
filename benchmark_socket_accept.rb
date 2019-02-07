#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'
require 'io/wait'
require 'socket'

class Integer
  def to_comma
    to_s.reverse.scan(/\d\d?\d?/).join(',').reverse
  end
end

repeat_num = Integer(ARGV.shift || '10')
chunk_num = Integer(ARGV.shift || '100')
puts "repeat: #{repeat_num.to_comma}"
puts "chunk: #{chunk_num.to_comma}"
puts "total: #{(repeat_num * chunk_num).to_comma}"

s = TCPServer.new('localhost', 0)
s_port = s.addr(:numeric)[1]

puts
puts 'TCPServer#accept'

t = []
repeat_num.times do
  c = []
  chunk_num.times do
    c << TCPSocket.new('localhost', s_port)
  end

  a = []
  t << Benchmark.measure{
    chunk_num.times do
      a << s.accept
    end
  }

  for i in a + c
    i.close
  end
end

puts Benchmark::CAPTION
puts t.inject{|s, i| s + i }

puts
puts 'IO#wait_readable, TCPServer#accept'

t = []
repeat_num.times do
  c = []
  chunk_num.times do
    c << TCPSocket.new('localhost', s_port)
  end

  a = []
  t << Benchmark.measure{
    chunk_num.times do
      begin
        is_readable = s.wait_readable(0.001)
      end until (is_readable) 
      a << s.accept
    end
  }

  for i in a + c
    i.close
  end
end

puts Benchmark::CAPTION
puts t.inject{|s, i| s + i }

puts
puts 'IO#wait_readable, TCPServer#accept_nonblock'

t = []
repeat_num.times do
  c = []
  chunk_num.times do
    c << TCPSocket.new('localhost', s_port)
  end

  a = []
  t << Benchmark.measure{
    chunk_num.times do
      begin
        is_readable = s.wait_readable(0.001)
      end until (is_readable) 
      a << s.accept_nonblock
    end
  }

  for i in a + c
    i.close
  end
end

puts Benchmark::CAPTION
puts t.inject{|s, i| s + i }

puts
puts 'TCPServer#accept_nonblock fail rescue'

t = []
repeat_num.times do
  t << Benchmark.measure{
    chunk_num.times do
      begin
        s.accept_nonblock
      rescue IO::WaitReadable
        # nothing to do.
      end
    end
  }
end

puts Benchmark::CAPTION
puts t.inject{|s, i| s + i }

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
