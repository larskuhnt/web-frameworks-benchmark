module CampingApp::Views
  def index
    p "I'm a camping application!"
    p "Time: #{Time.now.to_i}"
  end
end