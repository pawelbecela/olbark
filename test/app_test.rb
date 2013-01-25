require 'test_helper'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end
  
  def test_hello_world
    get '/'
    assert last_response.body.include?("Hello World!")
  end

end
