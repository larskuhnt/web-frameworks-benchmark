module CampingApp::Views
  def layout
    html do
      head do
        title { "Camping Application" }
        link :href => R(Stylesheet), :rel => 'stylesheet', :type => 'text/css'
      end
      body { 
        h1 "Camping Application"
        ul(:class => 'menu') do
          li { a("About", :href => R(About)) }
        end
        div(:id => 'container') do
          div(:id => 'main') { self << yield  }
        end
        div(:id => 'footer') { "All Rights Reserved" }
      }
    end
  end

  def index
    p "I'm a camping application!"
    p "Time: #{Time.now.to_i}"
    p "Session User ID: #{@state[:user_id]}"
  end
end
