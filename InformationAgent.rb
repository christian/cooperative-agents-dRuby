#!/usr/bin/env ruby

require 'Message'
require 'RecommenderAgent'
require 'AbstractAgent'
require 'thread'
require 'drb/drb'

INFORMATION_AGENT_URL = "druby://localhost:9998"

class InformationAgent < AbstractAgent
  
  def print_message(msg)
    puts "INFORMATION_AGENT #{Time.now.strftime("%H:%M:%S")}: #{msg}"
  end
  
  def print_status
    print_message " I'm #{@status}"
  end
  
  def initialize
    print_message "Hi. I'm the information agent running at '#{INFORMATION_AGENT_URL}' \n"
    @status = "IDLE"
    print_status
  end
  
  def get_recommendations(params)
    print_message "I'm being asked to get recommendations for user #{params[:user_id]}. Working ..."
    sleep(rand + 1)
    print_message "Done."
    return 1.upto(rand(10)).collect{|i| rand(10)}
  end
  
  def set_recommendation(params)
    print_message "I'm being aksed to set rating #{params[:rating_id]} for movie #{params[:movie_id]}. Working ..."
    sleep(rand)
    print_message "Done."
    return "OK"
  end
end

if __FILE__ == $0
  ia = InformationAgent.new
  DRb.start_service(INFORMATION_AGENT_URL, ia)
  #DRb.thread.join
  sleep
end
