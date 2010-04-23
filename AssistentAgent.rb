require 'AbstractAgent'
require 'Message'
require 'drb'

class AssistentAgent < AbstractAgent
  attr :environment_url
  attr :message_queue
  
  def initialize(base_url, environment_url)
    @environment_url = environment_url
    
    # bind to environment messages queue
    @message_queue = DRbObject.new nil, @environment_url
    @id = rand 10
    
    DRb.start_service
    print_message "AGENT #{id}: Hello I am agent #{id}"
  end
  
  def get_recommendations(agent_id, user_id)
    print_message "sending message GET_RECOMMENDATINOS for user #{user_id}..."    
    @message_queue.push_query(Message.new(agent_id, "Q", "GET_RECOMMENDATIONS", {:user_id => user_id}))

    msg = @message_queue.pop_answer(agent_id)
    print_message "I've got the answer I was looking for: " + msg.params.inspect
  end
  
  def set_recommendation(agent_id, user_id, movie_id, rating_id)
    print_message "sending message SET_RECOMMENDATION for movie #{movie_id} => rating #{rating_id}"
    params = {:movie_id => movie_id, 
              :rating_id => rating_id,
              :user_id => user_id}
    @message_queue.push_query(Message.new(agent_id, "Q", "SET_RECOMMENDATION", params))
    
    msg = @message_queue.pop_answer(agent_id)
    print_message "I've got the answer I was looking for: " + msg.params.inspect
  end
end
