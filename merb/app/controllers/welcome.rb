class Welcome < Application  
  before do
    session[:user_id] = 10
  end

  def index
    render :action => "index"
  end
  
  def about
    "Hello World!"
  end

end