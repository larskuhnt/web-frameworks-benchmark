class WelcomeController < ActionController::Base
  def index
    render :text => "Im a rails application"
  end
end