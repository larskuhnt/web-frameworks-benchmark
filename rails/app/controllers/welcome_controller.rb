class WelcomeController < ActionController::Base
  def index
    render :text => "This is the Rails Application"
  end
end