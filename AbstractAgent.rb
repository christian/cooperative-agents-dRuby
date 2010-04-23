class AbstractAgent
  attr :id  
  attr :status  # IDLE or BUSY
  
  def print_message(msg)
    puts "AGENT #{@id} #{Time.now.strftime("%H:%M:%S")}: #{msg}"
  end
end