class Message
  TYPES = ['GET_RECOMMENDATIONS', 'SET_RECOMMENDATION']
  
  attr_reader :kind # can be Q or A
  attr_reader :type
  attr_reader :params
  attr_reader :agent_id
  
  # type = type of the messages
  # params = a hash with the message contents
  # kind = "Q" (question), "A" answer
  def initialize(agent_id, kind, type, params)
    raise "Unknown message." unless TYPES.include?(type)
    @agent_id = agent_id
    @type = type
    @kind = kind
    @params = params
  end
end