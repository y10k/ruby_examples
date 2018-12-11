#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'
require 'socket'

n = ARGV.shift || '10_000'
n = n.to_i
puts "#{n.to_s.reverse.scan(/\d\d?\d?/).join(',').reverse} times."

a, b = UNIXSocket.socketpair
fork{
  a.close
  while (msg = b.read(4))
    msg
    #b.recv_io(UNIXSocket).close
    b.write('RECV')
  end
}
b.close

c, d = UNIXSocket.socketpair
fork{
  c.close
  while (msg = d.read(4))
    msg
    d.recv_io(UNIXSocket).close
    d.write('RECV')
  end
}
d.close

io = UNIXSocket.socketpair

Benchmark.bm(15) do |x|
  x.report('write') {
    n.times do
      a.write('SEND')
      #a.send_io(io[1])
      a.read(4) or abort('child process error')
    end
  }
  x.report('write & send_io') {
    n.times do
      c.write('SEND')
      c.send_io(io[1])
      c.read(4) or abort('child process error')
    end
  }
end

a.close
c.close
Process.wait
