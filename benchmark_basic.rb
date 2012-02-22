#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'
require 'monitor'
require 'thread'
require 'yaml'

class Integer
  def to_comma
    to_s.reverse.scan(/\d\d?\d?/).join(',').reverse
  end
end

n = ARGV.shift || '1_000_000'
n = n.to_i
puts "#{n.to_comma} times."

def method_no_args
end

def method_default(a=:foo)
end

def method_a1(a)
end

def method_a2(a, b)
end

def method_a3(a, b, c)
end

def method_args(*args)
end

def method_keywords(options={})
end

def method_block
  yield
end

Struct_member1 = Struct.new(:a)

class Object_attr_accessor
  attr_accessor :a
end

class Object_def_accessor
  def a
    @a
  end

  def a=(v)
    @a = v
  end
end

Benchmark.bm(30) do |x|
  x.report('empty') {
    n.times do
    end
  }
  x.report('if') {
    n.times do
      if (true) then
      end
    end
  }
  x.report('unless') {
    n.times do
      unless (false) then
      end
    end
  }
  x.report('case 1') {
    n.times do
      case (:foo)
      when :foo
      end
    end
  }
  x.report('case 2') {
    n.times do
      case (:bar)
      when :foo
      when :bar
      end
    end
  }
  x.report('case 3') {
    n.times do
      case (:baz)
      when :foo
      when :bar
      when :baz
      end
    end
  }
  x.report('case else') {
    n.times do
      case (:none)
      when :foo
      when :bar
      when :baz
      else
      end
    end
  }
  x.report('whlie') {
    n.times do
      while (false)
      end
    end
  }
  x.report('until') {
    n.times do
      until (true)
      end
    end
  }
  x.report('for') {
    zero = []
    n.times do
      for i in zero
      end
    end
  }
  x.report('1.times') {
    n.times do
      1.times do
      end
    end
  }
  x.report('1.times break') {
    n.times do
      1.times do
        break
      end
    end
  }
  x.report('1.times next') {
    n.times do
      1.times do
        next
      end
    end
  }
  x.report('ensure') {
    n.times do
      begin
      ensure
      end
    end
  }
  x.report('raise rescue') {
    n.times do
      begin
        raise 'test'
      rescue
      end
    end
  }
  x.report('raise rescue ensure') {
    n.times do
      begin
        raise 'test'
      rescue
      ensure
      end
    end
  }
  x.report('catch throw') {
    n.times do
      catch(:foo) {
        throw(:foo)
      }
    end
  }
  x.report('method_no_args') {
    n.times do
      method_no_args
    end
  }
  x.report('send :method_no_args') {
    n.times do
      send(:method_no_args)
    end
  }
  x.report('send "method_no_args"') {
    n.times do
      send("method_no_args")
    end
  }
  x.report('method object :method_no_args') {
    m = method(:method_no_args)
    n.times do
      m.call
    end
  }
  x.report('method_default') {
    n.times do
      method_default
    end
  }
  x.report('method_a1') {
    n.times do
      method_a1(1)
    end
  }
  x.report('method_a2') {
    n.times do
      method_a2(1, 2)
    end
  }
  x.report('method_a3') {
    n.times do
      method_a3(1, 2, 3)
    end
  }
  x.report('method_args') {
    n.times do
      method_args(1, 2, 3)
    end
  }
  x.report('method_keywords') {
    n.times do
      method_keywords(foo: 1, bar: 2, baz: 3)
    end
  }
  x.report('method_block do end') {
    n.times do
      method_block do
      end
    end
  }
  x.report('method_block{}') {
    n.times do
      method_block{
      }
    end
  }
  x.report('proc{}.call') {
    code = proc{}
    n.times do
      code.call
    end
  }
  x.report('proc{}.call(1)') {
    code = proc{|a|}
    n.times do
      code.call(1)
    end
  }
  x.report('proc{}.call(1,2)') {
    code = proc{|a,b|}
    n.times do
      code.call(1,2)
    end
  }
  x.report('proc{}.call(1,2,3)') {
    code = proc{|a,b,c|}
    n.times do
      code.call(1,2,3)
    end
  }
  x.report('Object::RUBY_VERSION') {
    n.times do
      Object::RUBY_VERSION
    end
  }
  x.report('Object.const_get :RUBY_VERSION') {
    n.times do
      Object.const_get(:RUBY_VERSION)
    end
  }
  x.report('Object.const_get "RUBY_VERSION"') {
    n.times do
      Object.const_get("RUBY_VERSION")
    end
  }
  x.report('a') {
    a = nil
    n.times do
      a
    end
  }
  x.report('a = nil') {
    n.times do
      a = nil
    end
  }
  x.report('@a') {
    @a = nil
    n.times do
      @a
    end
  }
  x.report('instance_variable_get :@a') {
    @a = nil
    n.times do
      instance_variable_get(:@a)
    end
  }
  x.report('instance_variable_get "@a"') {
    @a = nil
    n.times do
      instance_variable_get("@a")
    end
  }
  x.report('@a = nil') {
    n.times do
      @a = nil
    end
  }
  x.report('instance_variable_set :@a') {
    n.times do
      instance_variable_set(:@a, nil)
    end
  }
  x.report('instance_variable_set "@a"') {
    n.times do
      instance_variable_set("@a", nil)
    end
  }
  x.report('$a') {
    $a = nil
    n.times do
      $a
    end
  }
  x.report('$a = nil') {
    n.times do
      $a = nil
    end
  }
  x.report('ary[0]') {
    ary = [ nil ]
    n.times do
      ary[0]
    end
  }
  x.report('ary[0]=nil') {
    ary = [ nil ]
    n.times do
      ary[0] = nil
    end
  }
  x.report('hash[:foo]') {
    hash = { :foo => nil }
    n.times do
      hash[:foo]
    end
  }
  x.report('hash[:foo] = nil') {
    hash = { :foo => nil }
    n.times do
      hash[:foo] = nil
    end
  }
  x.report('struct_member.a') {
    s = Struct_member1.new
    s.a = nil
    n.times do
      s.a
    end
  }
  x.report('struct_member.a = nil') {
    s = Struct_member1.new
    n.times do
      s.a = nil
    end
  }
  x.report('object_attr_accessor.a') {
    o = Object_attr_accessor.new
    o.a = nil
    n.times do
      o.a
    end
  }
  x.report('object_attr_accessor.a = nil') {
    o = Object_attr_accessor.new
    n.times do
      o.a = nil
    end
  }
  x.report('object_def_accessor.a') {
    o = Object_def_accessor.new
    o.a = nil
    n.times do
      o.a
    end
  }
  x.report('object_def_accessor.a = nil') {
    o = Object_def_accessor.new
    n.times do
      o.a = nil
    end
  }
  x.report('"a".succ') {
    n.times do
      "a".succ
    end
  }
  x.report('"a".succ!') {
    n.times do
      "a".succ!
    end
  }
  x.report('"a" + "b"') {
    n.times do
      "a" + "b"
    end
  }
  x.report('"a" << "b"') {
    n.times do
      "a" << "b"
    end
  }
  x.report('"a" * 2') {
    n.times do
      "a" * 2
    end
  }
  x.report('1.succ') {
    n.times do
      1.succ
    end
  }
  x.report('1 + 1') {
    n.times do
      1 + 1
    end
  }
  x.report('1 - 1') {
    n.times do
      1 - 1
    end
  }
  x.report('1 * 1') {
    n.times do
      1 * 1
    end
  }
  x.report('1 / 1') {
    n.times do
      1 / 1
    end
  }
  x.report('Bignum#succ') {
    n.times do
      0xFFFF_FFFF_FFFF_FFFF.succ
    end
  }
  x.report('Bignum + 1') {
    n.times do
      0xFFFF_FFFF_FFFF_FFFF + 1
    end
  }
  x.report('Bignum - 1') {
    n.times do
      0xFFFF_FFFF_FFFF_FFFF - 1
    end
  }
  x.report('Bignum * 1') {
    n.times do
      0xFFFF_FFFF_FFFF_FFFF * 1
    end
  }
  x.report('Bignum / 1') {
    n.times do
      0xFFFF_FFFF_FFFF_FFFF / 1
    end
  }
  x.report('1.0 + 1.0') {
    n.times do
      1.0 + 1.0
    end
  }
  x.report('1.0 - 1.0') {
    n.times do
      1.0 - 1.0
    end
  }
  x.report('1.0 * 1.0') {
    n.times do
      1.0 * 1.0
    end
  }
  x.report('1.0 / 1.0') {
    n.times do
      1.0 / 1.0
    end
  }
  x.report('1.0 + 1') {
    n.times do
      1.0 + 1
    end
  }
  x.report('1.0 - 1') {
    n.times do
      1.0 - 1
    end
  }
  x.report('1.0 * 1') {
    n.times do
      1.0 * 1
    end
  }
  x.report('1.0 / 1') {
    n.times do
      1.0 / 1
    end
  }
  x.report(':foo == :bar') {
    n.times do
      :foo == :bar
    end
  }
  x.report(':foo != :bar') {
    n.times do
      :foo != :bar
    end
  }
  x.report('"a" == "b"') {
    n.times do
      "a" == "b"
    end
  }
  x.report('"a" != "b"') {
    n.times do
      "a" != "b"
    end
  }
  x.report('"a" > "b"') {
    n.times do
      "a" > "b"
    end
  }
  x.report('"a" < "b"') {
    n.times do
      "a" < "b"
    end
  }
  x.report('"a" >= "b"') {
    n.times do
      "a" >= "b"
    end
  }
  x.report('"a" <= "b"') {
    n.times do
      "a" <= "b"
    end
  }
  x.report('1 == 2') {
    n.times do
      1 == 2
    end
  }
  x.report('1 != 2') {
    n.times do
      1 != 2
    end
  }
  x.report('1 > 2') {
    n.times do
      1 > 2
    end
  }
  x.report('1 < 2') {
    n.times do
      1 < 2
    end
  }
  x.report('1 >= 2') {
    n.times do
      1 >= 2
    end
  }
  x.report('1 <= 2') {
    n.times do
      1 <= 2
    end
  }
  x.report('Object == Object') {
    a = Object.new
    b = Object.new
    n.times do
      a == b
    end
  }
  x.report('Object != Object') {
    a = Object.new
    b = Object.new
    n.times do
      a != b
    end
  }
  x.report('"foo" =~ /foo/') {
    n.times do
      "foo" =~ /foo/
    end
  }
  x.report('"foo" =~ /bar/') {
    n.times do
      "foo" =~ /bar/
    end
  }
  x.report('"foo" =~ /foo|bar/') {
    n.times do
      "foo" =~ /bar/
    end
  }
  x.report('"1 23 456" =~ /(\d+)/') {
    n.times do
      "1 23 456" =~ /(\d+)/
    end
  }
  x.report('"1 23 456" =~ /(\d+) (\d+)/') {
    n.times do
      "1 23 456" =~ /(\d+) (\d+)/
    end
  }
  x.report('"1 23 456" =~ /(\d+) (\d+) (\d+)/') {
    n.times do
      "1 23 456" =~ /(\d+) (\d+) (\d+)/
    end
  }
  x.report('Marshal.dump(:foo)') {
    obj = :foo
    n.times do
      Marshal.dump(obj)
    end
  }
  x.report('Marshal.load => :foo') {
    s = Marshal.dump(:foo)
    n.times do
      Marshal.load(s)
    end
  }
  x.report('Marshal.dump("a")') {
    obj = "a"
    n.times do
      Marshal.dump(obj)
    end
  }
  x.report('Marshal.load => "a"') {
    s = Marshal.dump("a")
    n.times do
      Marshal.load(s)
    end
  }
  x.report('Marshal.dump(1)') {
    obj = 1
    n.times do
      Marshal.dump(obj)
    end
  }
  x.report('Marshal.load => 1') {
    s = Marshal.dump(1)
    n.times do
      Marshal.load(s)
    end
  }
  x.report('Marshal.dump(Object)') {
    obj = Object.new
    n.times do
      Marshal.dump(obj)
    end
  }
  x.report('Marshal.load => Object') {
    s = Marshal.dump(Object.new)
    n.times do
      Marshal.load(s)
    end
  }
  x.report('Marshal.dump([])') {
    obj = []
    n.times do
      Marshal.dump(obj)
    end
  }
  x.report('Marshal.load => []') {
    s = Marshal.dump([])
    n.times do
      Marshal.load(s)
    end
  }
  x.report('Marshal.dump({})') {
    obj = {}
    n.times do
      Marshal.dump(obj)
    end
  }
  x.report('Marshal.load => {}') {
    s = Marshal.dump({})
    n.times do
      Marshal.load(s)
    end
  }
  x.report('[1/10] YAML.dump(:foo)') {
    obj = :foo
    (n / 10).times do
      YAML.dump(obj)
    end
  }
  x.report('[1/10] YAML.load => :foo') {
    s = YAML.dump(:foo)
    (n / 10).times do
      YAML.load(s)
    end
  }
  x.report('[1/10] YAML.dump("a")') {
    obj = "a"
    (n / 10).times do
      YAML.dump(obj)
    end
  }
  x.report('[1/10] YAML.load => "a"') {
    s = YAML.dump("a")
    (n / 10).times do
      YAML.load(s)
    end
  }
  x.report('[1/10] YAML.dump(1)') {
    obj = 1
    (n / 10).times do
      YAML.dump(obj)
    end
  }
  x.report('[1/10] YAML.load => 1') {
    s = YAML.dump(1)
    (n / 10).times do
      YAML.load(s)
    end
  }
  x.report('[1/10] YAML.dump(Object)') {
    obj = Object.new
    (n / 10).times do
      YAML.dump(obj)
    end
  }
  x.report('[1/10] YAML.load => Object') {
    s = YAML.dump(Object.new)
    (n / 10).times do
      YAML.load(s)
    end
  }
  x.report('[1/10] YAML.dump([])') {
    obj = []
    (n / 10).times do
      YAML.dump(obj)
    end
  }
  x.report('[1/10] YAML.load => []') {
    s = YAML.dump([])
    (n / 10).times do
      YAML.load(s)
    end
  }
  x.report('[1/10] YAML.dump({})') {
    obj = {}
    (n / 10).times do
      YAML.dump(obj)
    end
  }
  x.report('[1/10] YAML.load => {}') {
    s = YAML.dump({})
    (n / 10).times do
      YAML.load(s)
    end
  }
  x.report('[1/1000] Process.fork&wait') {
    (n / 1000).times do
      Process.fork{
        exit!
      }
      Process.wait
    end
  }
  x.report('[1/100] Thread.new&join') {
    (n / 100).times do
      Thread.new{
      }.join
    end
  }
  x.report('Mutex#synchronize') {
    lock = Mutex.new
    n.times do
      lock.synchronize{
      }
    end
  }
  x.report('ConditionVariable#signal') {
    cond = ConditionVariable.new
    n.times do
      cond.signal
    end
  }
  x.report('ConditionVariable#broadcast') {
    cond = ConditionVariable.new
    n.times do
      cond.broadcast
    end
  }
  x.report('ConditionVariable#wait') {
    lock = Mutex.new
    state = :push
    cond_push = ConditionVariable.new
    cond_back = ConditionVariable.new

    th_push = Thread.new{
      lock.synchronize{
        (n / 2).times do
          while (state != :push)
            cond_push.wait(lock)
          end
          cond_back.signal
          state = :back
        end
      }
    }

    th_back = Thread.new{
      lock.synchronize{
        (n / 2).times do
          while (state != :back)
            cond_back.wait(lock)
          end
          cond_push.signal
          state = :push
        end
      }
    }

    th_push.join
    th_back.join
  }
  x.report('Queue') {
    q = Queue.new
    th_product = Thread.new{
      n.times do
        q.push(:foo)
      end
    }

    n.times do
      q.pop
    end

    th_product.kill
  }
  x.report('SizedQueue.new') {
    q = SizedQueue.new(10)
    th_product = Thread.new{
      n.times do
        q.push(:foo)
      end
    }

    n.times do
      q.pop
    end

    th_product.kill
  }
  x.report('Monitor#synchronize') {
    mon = Monitor.new
    n.times do
      mon.synchronize{
      }
    end
  }
  [ 512, 1024, 8192, 16384, 32768 ].each do |sz|
    x.report("IO#read #{sz.to_comma} bytes") {
      File.open('/dev/zero', 'rb:ascii-8bit') {|re|
        n.times do
          re.read(sz)
        end
      }
    }
    x.report("IO#write #{sz.to_comma} bytes") {
      File.open('/dev/null', 'wb:ascii-8bit') {|wr|
        s = ' ' * sz
        n.times do
          wr.write(s)
        end
      }
    }
    x.report("IO#sysread #{sz.to_comma} bytes") {
      File.open('/dev/zero', 'rb:ascii-8bit') {|re|
        n.times do
          re.sysread(sz)
        end
      }
    }
    x.report("IO#syswrite #{sz.to_comma} bytes") {
      File.open('/dev/null', 'wb:ascii-8bit') {|wr|
        s = ' ' * sz
        n.times do
          wr.syswrite(s)
        end
      }
    }
  end
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
