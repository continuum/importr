# -*- encoding : utf-8 -*-
module Importr
  class Engine < ::Rails::Engine
    
    isolate_namespace Importr
    config.generators do |g|
      g.test_framework  :rspec,
                        :fixture_replacement => :factory_girl ,
                        :dir => "spec/factories"
      g.integration_tool :rspec
    end

    initializer "Activeadmin Importer interface" do |app|
      ::ActiveAdmin::ResourceDSL.send(:include, Importr::ActiveAdmin) if defined? ::ActiveAdmin
    end

  end

end
