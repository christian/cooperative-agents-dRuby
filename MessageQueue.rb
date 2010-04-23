require 'Message'

class MessageQueue
  attr :messages # ann array of messages
  
  def initialize
    @messages = Array.new
  end
  
  def push_query(message)
    @messages << message
  end

  def pop_query
    message = nil
    while true
      message = get_first_query
      if message == nil
        sleep(0.01)
      else
        return message
      end
    end
  end
  
  def push_answer(message)
    @messages <<  message
  end
  
  def pop_answer(agent_id)
    message = nil
    i = 0
    while true
      message = get_answer_for_agent(agent_id)
      if message == nil
        sleep(0.01)
      else
        return message
      end
    end
  end
  
  private
  def get_first_query
    @messages.each do |msg|
      if msg.kind == "Q"
        message = msg.dup
        @messages.delete(msg)
        return message
      end
    end
    return nil
  end
  
  def get_answer_for_agent(agent_id)
    @messages.each do |msg|
      if msg.agent_id == agent_id && msg.kind == "A"
        message = msg.dup
        @messages.delete(msg)
        return message
      end
    end
    return nil
  end
end