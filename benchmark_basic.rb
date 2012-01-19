#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'
require 'thread'

n = ARGV.shift || '1_000_000'
n = n.to_i
puts "#{n.to_s.reverse.scan(/\d\d?\d?/).join(',').reverse} times."

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
  x.report('Process.fork&wait (1/1000)') {
    (n / 1000).times do
      Process.fork{
        exit!
      }
      Process.wait
    end
  }
  x.report('Thread.new&join (1/100)') {
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
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
