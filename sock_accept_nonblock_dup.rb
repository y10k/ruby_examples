#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'io/wait'
require 'socket'

s = TCPServer.new(0)
p [ :listen, s ]

fork{
  begin
    p [ $$, :wait, s.wait_readable(3600) ]
    p [ $$, :accept, s.accept_nonblock ]
  rescue
    p [ $$, $! ]
  end
}

fork{
  begin
    p [ $$, :wait, s.wait_readable(3600) ]
    p [ $$, :accept, s.accept_nonblock ]
  rescue
    p [ $$, $! ]
  end
}

sleep 1

fork{
  c = TCPSocket.new('localhost', s.local_address.ip_port)
  c.close
}

Process.waitall

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
