require 'sinatra/partial'
require 'sinatra/base'
require 'haml'
require 'rubygems'
require 'pony'

class App < Sinatra::Base
  register Sinatra::Partial

  set :views, "app/views"
  set :haml, { :format => :html5 }

  enable :partial_underscores

  helpers do
    # container for helpers
    # that can be used inside views
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
  
  get '/form' do
    erb :form
  end
  
  post '/form' do  
    Pony.mail({
      :to => 'pawbecela@gmail.com',
      :body => "#{params[:message]}, #{params[:email]}",
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
    'email sent'
  end
end
