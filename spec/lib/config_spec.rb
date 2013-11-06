require 'spec_helper'

describe "Config class" do
  before(:all) do

    Importr::Config.setup do |config|
      config.web_socket_class  = 'SomeWebsocketWrapper' 
      config.web_socket_method = "publish"
    end
  end

  it "should have all the required keys" do
    Importr::Config.web_socket_class.should_not be_empty
    Importr::Config.web_socket_class.should eq 'SomeWebsocketWrapper' 
  end

end