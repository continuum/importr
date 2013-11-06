require "importr/engine"
require "active_importer"

module Importr
  autoload :VERSION, 'importr/version.rb'
  autoload :Config, 'importr/config.rb'
  autoload :Notifier, 'importr/notifier.rb'
  autoload :Importer, 'importr/importer'
  autoload :ActiveAdmin, 'importr/active_admin' if defined? ::ActiveAdmin
end

