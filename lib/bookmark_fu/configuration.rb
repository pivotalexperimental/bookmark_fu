module BookmarkFu
  class << self
    def services
      Configuration.services
    end
  end

  class Configuration
    class << self
      def instance
        @instance ||= new
      end
      attr_writer :instance

      def all_services
        @all_services ||= []
      end

      def to_yaml
        all_services.collect {|service| service.to_s.split("::").last}.to_yaml
      end

      def method_missing(method_name, *args, &block)
        self.instance.__send__(method_name, *args, &block)
      end
    end

    def initialize
      refresh!
    end

    def configuration_file
      @configuration_file ||= "#{RAILS_ROOT}/config/bookmark_fu.yml"
    end
    attr_writer :configuration_file
    attr_accessor :services

    def refresh!
      if File.exists?(configuration_file.to_s)
        service_names = YAML.load_file(configuration_file)
        @services = service_names.collect {|name| BookmarkFu.const_get(name)}
      else
        @services = self.class.all_services
      end
    end
  end
end