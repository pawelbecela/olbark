require 'sinatra/partial'
require 'sinatra/base'
require 'haml'
require 'rubygems'
require 'pony'

class App < Sinatra::Base
  register Sinatra::Partial
  
  # enable :sessions
  #   use Rack::Flash, :sweep => true

  set :views, "app/views"
  set :haml, { :format => :html5 }

  enable :partial_underscores

  helpers do
    # def flash_types
    #     [:success, :notice, :warning, :error]
    #   end
  end

  get '/' do
    haml :index
  end
  
  get '/about' do
    haml :about
  end

  get '/offer' do
    haml :offer
  end
  
  get '/contact' do
    haml :contact
  end
  
  get '/' do
    erb :layout
  end
  
  post '/' do  
    Pony.mail({
      :to => 'pawbecela@gmail.com',
      :body => "Wiadomosc od: #{params[:email]}, o tresci: #{params[:body]}",
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'pawbecela@gmail.com',
        :password             => '1qaz2wsx3edc4rfv',
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
      }
    })
    
    # flash[:success] = "Huj"
    redirect '/'
  end
end
