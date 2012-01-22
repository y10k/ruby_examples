#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'benchmark'

class LRUCache_Hash
  def initialize(max_entries)
    @max_entries = max_entries
    @cache = {}
  end

  def []=(key, value)
    @cache.delete(key)
    @cache[key] = value

    if (@cache.size > @max_entries) then
      key = nil
      @cache.each_key do |k|
	key = k
	break
      end
      @cache.delete(key)
    end

    value
  end

  def [](key)
    if (@cache.key? key) then
      value = @cache.delete(key)
      @cache[key] = value
    end
  end
end

class LRUCache_LinkList
  def initialize(max_entries=1000)
    @max_entries = max_entries
    @first = [ nil, nil, nil ]	# [ next, key, value ]
    @last = @first
    @cache = {}
  end

  attr_reader :max_entries

  def insert_last(node)
    parent_node = @last
    parent_node[0] = node
    @last = node
    @last[0] = nil
    @cache[node[1]] = parent_node
  end
  private :insert_last

  def fetch_node(key)
    parent_node = @cache[key] or raise 'internal error'
    node = parent_node[0]
    if (node != @last) then
      parent_node[0] = node[0]
      @cache[parent_node[0][1]] = parent_node
      insert_last(node)
    end
    node
  end
  private :fetch_node

  def []=(key, value)
    if (@cache.key? key) then
      fetch_node(key)[2] = value
    else
      node = [ nil, key, value ]
      insert_last(node)
    end

    if (@cache.size > @max_entries) then
      node = @first[0]
      @first[0] = @first[0][0]
      @cache[@first[0][1]] = @first
      @cache.delete(node[1])
    end

    value
  end

  def [](key)
    if (@cache.key? key) then
      fetch_node(key)[2]
    end
  end
end

class LRUCache_Count
  def initialize(max_entries)
    @max_entries = max_entries
    @count = 0
    @cache = {}
  end

  def []=(key, value)
    c = @count
    @count += 1

    if (c_pair = @cache[key]) then
      c_pair[0] = c
      c_pair[1] = value
    else
      if (@cache.size == @max_entries) then
        ordered_keys = @cache.keys.sort_by{|k| @cache[k][0] }
        len = ordered_keys.length
        for k in ordered_keys[0..(len/2)]
          @cache.delete(k)
        end
      end
      @cache[key] = [ c, value ]
      value
    end
  end

  def [](key)
    if (c_pair = @cache[key]) then
      c_pair[0] = @count
      @count += 1
      c_pair[1]
    end
  end
end

n = ARGV.shift || '1_000_000'
n = n.to_i
puts "#{n.to_s.reverse.scan(/\d\d?\d?/).join(',').reverse} times."

Benchmark.bm(25) do |x|
  x.report('empty loop') {
    n.times do
      # nothing to do.
    end
  }

  hash = Hash.new
  lru_hash = LRUCache_Hash.new(3)
  lru_llist = LRUCache_LinkList.new(3)
  lru_count = LRUCache_Count.new(3)

  x.report('Hash store') {
    n.times do
      hash[:foo] = 1
      hash[:bar] = 2
      hash[:baz] = 3
    end
  }

  x.report('LRUCache_Hash store') {
    n.times do
      lru_hash[:foo] = 1
      lru_hash[:bar] = 2
      lru_hash[:baz] = 3
    end
  }

  x.report('LRUCache_LinkList store') {
    n.times do
      lru_llist[:foo] = 1
      lru_llist[:bar] = 2
      lru_llist[:baz] = 3
    end
  }

  x.report('LRUCache_Count store') {
    n.times do
      lru_count[:foo] = 1
      lru_count[:bar] = 2
      lru_count[:baz] = 3
    end
  }

  x.report('Hash fetch') {
    n.times do
      hash[:foo]
      hash[:bar]
      hash[:baz]
    end
  }

  x.report('LRUCache_Hash fetch') {
    n.times do
      lru_hash[:foo]
      lru_hash[:bar]
      lru_hash[:baz]
    end
  }

  x.report('LRUCache_LinkList fetch') {
    n.times do
      lru_llist[:foo]
      lru_llist[:bar]
      lru_llist[:baz]
    end
  }

  x.report('LRUCache_Count fetch') {
    n.times do
      lru_count[:foo]
      lru_count[:bar]
      lru_count[:baz]
    end
  }

  lru_hash = LRUCache_Hash.new(3)
  lru_llist = LRUCache_LinkList.new(3)

  x.report('LRUCache_Hash overflow') {
    n.times do
      lru_hash[:foo] = 1
      lru_hash[:bar] = 2
      lru_hash[:baz] = 3
    end
  }


  x.report('LRUCache_LinkList overflow') {
    n.times do
      lru_llist[:foo] = 1
      lru_llist[:bar] = 2
      lru_llist[:baz] = 3
    end
  }

  x.report('LRUCache_Count overflow') {
    n.times do
      lru_count[:foo] = 1
      lru_count[:bar] = 2
      lru_count[:baz] = 3
    end
  }
end

# Local Variables:
# mode: Ruby
# indent-tabs-mode: nil
# End:
