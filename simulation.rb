#!/usr/bin/env ruby

require 'AssistentAgent'

ENVIRONMENT_URL = "druby://localhost:9999"
BASE_URL = "druby://localhost:9999"

if __FILE__ == $0
  puts "Starting agents simulation"
  puts "-----------------------------"
  
  1.upto(10) do
    Thread.new {
      agent = AssistentAgent.new(BASE_URL, ENVIRONMENT_URL)
      agent.get_recommendations(agent.id, 1)
      agent.set_recommendation(agent.id, 12, 2, 3)
    }
  end
  # wait for all threads to finish
  Thread.list.each do |t|
    t.join
  end
  puts "-----------------------------"
  puts "End of simulation"
end