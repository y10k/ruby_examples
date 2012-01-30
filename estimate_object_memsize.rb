#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'date'

def get_process_rsz(pid)
  IO.popen([ 'ps', '-p', pid.to_s, '-o', 'rsz' ]) {|p_in|
    p_in.gets
    p_in.gets.to_f
  }
end

def get_object_memsize(num_obj)
  ps_interval = 1
  ptr_siz = (RUBY_PLATFORM =~ /x86_64/) ? 8 : 4

  re, wr = IO.pipe
  pid = fork{
    wr.close
    re.gets

    a = Array.new(num_obj)
    a.length.times do |i|
      a[i] = yield
    end
    re.gets
  }
  re.close

  sleep(ps_interval)
  first_size_kb = get_process_rsz(pid)
  wr.puts

  sleep(ps_interval)
  last_size_kb = get_process_rsz(pid)
  wr.puts

  Process.wait(pid)

  ((last_size_kb - first_size_kb) * 1024 - num_obj * ptr_siz) / num_obj
end

class Object_ivar1
  def initialize
    @v1 = nil
  end
end

class Object_ivar2
  def initialize
    @v1 = nil
    @v2 = nil
  end
end

class Object_ivar3
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
  end
end

class Object_ivar4
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
  end
end

class Object_ivar5
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
    @v5 = nil
  end
end

class Object_ivar6
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
    @v5 = nil
    @v6 = nil
  end
end

class Object_ivar7
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
    @v5 = nil
    @v6 = nil
    @v7 = nil
  end
end

class Object_ivar8
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
    @v5 = nil
    @v6 = nil
    @v7 = nil
    @v8 = nil
  end
end

class Object_ivar9
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
    @v5 = nil
    @v6 = nil
    @v7 = nil
    @v8 = nil
    @v9 = nil
  end
end

class Object_ivar10
  def initialize
    @v1 = nil
    @v2 = nil
    @v3 = nil
    @v4 = nil
    @v5 = nil
    @v6 = nil
    @v7 = nil
    @v8 = nil
    @v9 = nil
    @v10 = nil
  end
end

Struct_member1 = Struct.new(:v1)
Struct_member2 = Struct.new(:v1, :v2)
Struct_member3 = Struct.new(:v1, :v2, :v3)
Struct_member4 = Struct.new(:v1, :v2, :v3, :v4)
Struct_member5 = Struct.new(:v1, :v2, :v3, :v4, :v5)
Struct_member6 = Struct.new(:v1, :v2, :v3, :v4, :v5, :v6)
Struct_member7 = Struct.new(:v1, :v2, :v3, :v4, :v5, :v6, :v7)
Struct_member8 = Struct.new(:v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8)
Struct_member9 = Struct.new(:v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8, :v9)
Struct_member10 = Struct.new(:v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8, :v9, :v10)

num_obj = ARGV.shift || '1_000_000'
num_obj = num_obj.to_i

[ 
  '1 << 0',
  '1 << 32',
  '1 << 64',
  'Float(1)',
  'Complex(1)',
  'Rational(1)',
  '"" << ""',
  '"" << "1"',
  '"" << "12"',
  '"" << "123"',
  '"" << "1234567890"',
  '"" << "12345678901"',
  '"" << "123456789012"',
  '"" << "1234567890123"',
  '"" << "12345678901234567890"',
  '"" << "123456789012345678901"',
  '"" << "1234567890123456789012"',
  '"" << "12345678901234567890123"',
  '"" << "123456789012345678901234"',
  '"" << "1234567890123456789012345"',
  '[]',
  '[nil]',
  '[nil,nil]',
  '[nil,nil,nil]',
  '[nil,nil,nil,nil]',
  '[nil,nil,nil,nil,nil]',
  '[nil,nil,nil,nil,nil,nil]',
  '[nil,nil,nil,nil,nil,nil,nil]',
  '[nil,nil,nil,nil,nil,nil,nil,nil]',
  '[nil,nil,nil,nil,nil,nil,nil,nil,nil]',
  '[nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]',
  '{}',
  '{1=>nil}',
  '{1=>nil,2=>nil}',
  '{1=>nil,2=>nil,3=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil,5=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil,7=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil,7=>nil,8=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil,7=>nil,8=>nil,9=>nil}',
  '{1=>nil,2=>nil,3=>nil,4=>nil,5=>nil,6=>nil,7=>nil,8=>nil,9=>nil,10=>nil}',
  'Object.new',
  'Object_ivar1.new',
  'Object_ivar2.new',
  'Object_ivar3.new',
  'Object_ivar4.new',
  'Object_ivar5.new',
  'Object_ivar6.new',
  'Object_ivar7.new',
  'Object_ivar8.new',
  'Object_ivar9.new',
  'Object_ivar10.new',
  'Struct_member1.new',
  'Struct_member2.new',
  'Struct_member3.new',
  'Struct_member4.new',
  'Struct_member5.new',
  'Struct_member6.new',
  'Struct_member7.new',
  'Struct_member8.new',
  'Struct_member9.new',
  'Struct_member10.new',
  'Range.new(1, 2)',
  'Regexp.new("")',
  'Mutex.new',
  'Time.new',
  'Date.new',
  'DateTime.new'
].each do |expr, factory|
  unless (factory) then
    factory = eval("proc{ #{expr} }")
  end
  printf "%- 30s %g\n", expr, get_object_memsize(num_obj) { factory.call }
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
