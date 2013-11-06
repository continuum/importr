require 'spec_helper'

describe "Config class" do
  before(:all) do

    Importr::Config.setup do |config|
      config.web_socket_class  = 'SomeWebsocketWrapper' 
      config.web_socket_method = "publish"
      config.websocket_url_service    = "http://somepath:6000"
      config.websocket_client_script  = "http://somepath:600/client.js"
    end
  end

  it "should have all the required keys" do
    Importr::Config.web_socket_class.should_not     be_empty
    Importr::Config.web_socket_class.should         eq 'SomeWebsocketWrapper' 
    Importr::Config.websocket_url_service.should    eq "http://somepath:6000"
    Importr::Config.websocket_client_script.should eq "http://somepath:600/client.js"
  end

end