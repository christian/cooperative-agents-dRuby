require 'InformationAgent'

class RecommenderAgent
  INFORMATION_AGENT_URL = "druby://localhost:9998"
  ENVIRONMENT_URL = "druby://localhost:9999"
  
  def initialize
    
  end
  
  def ask_information(message)
    information_agent = DRbObject.new nil, INFORMATION_AGENT_URL
    return information_agent.send(message.type.downcase, message.params)
    # if message_type == "GET_RECOMMENDATIONS"
    #   information_agent.get_recommendations(message_params)
    # elsif message_type == "POST_RECOMMENDATION"
    #   information_agent.get_recommendations(message_params)
  end

end