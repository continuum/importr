
module Importr
  class Notifier

    def self.notify(channel, msg)
      if Importr::Config.web_socket_class.present? and defined?(Importr::Config.web_socket_class.constantize)
        Importr::Config.web_socket_class.constantize.send(Importr::Config.web_socket_method.to_sym, channel, msg)
      end
    end

  end
end