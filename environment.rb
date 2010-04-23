#!/usr/bin/env ruby

# shared queue server
require 'Message'
require 'RecommenderAgent'
require 'MessageQueue'
require 'thread'
require 'drb/drb'

ENVIRONMENT_URL = "druby://localhost:9999"

def print_message(msg)
  puts "ENVIRONMENT #{Time.now.strftime("%H:%M:%S")}: #{msg}"
end

if __FILE__ == $0
  message_queue = MessageQueue.new
  
  print_message "I'm initializing at '#{ENVIRONMENT_URL}'"
  print_message "I have a shared message queue"
  DRb.start_service(ENVIRONMENT_URL, message_queue)
  # sleep
  
  # trap("INT") { DRb.stop_service }
  # DRb.thread.join
  
  while true
    message = message_queue.pop_query
    print_message "Recieved message from AGENT #{message.agent_id}: #{message.type}, params -> #{message.params.inspect}"

    print_message "Asking the recommender agent"
    rc = RecommenderAgent.new
    response = rc.ask_information(message)
    
    print_message "Recommender sent me message for AGENT #{message.agent_id}: #{message.type} -> #{response.inspect}"
    answer = Message.new(message.agent_id, "A", message.type, {:recommendations => response})
    message_queue.push_answer(answer)
    
    print_message "Putting this message in queue."
  end
end