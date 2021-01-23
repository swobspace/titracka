#!/usr/bin/env ruby
# create test data with mustermann gmbh

ENV['RAILS_ENV'] ||= 'development'
require File.dirname(__FILE__) + '/../config/environment.rb'

if ARGV[0].blank?
  puts "missing argument user_id"
  exit 1
else
  user_id = ARGV[0]
end

period = 28 # 4 weeks

time_accountings = TimeAccounting.where(user_id: user_id).where("date > ?", period.days.before(Date.today))

weighted = Hash.new

time_accountings.each do |ta|
  weighted[ta.task_id] = 0 if weighted[ta.task_id].nil?
  weighted[ta.task_id] += (period - (Date.today - ta.date).to_i)
end

weighted = weighted.sort_by{|k,v| v}.reverse.to_h
puts weighted.inspect
