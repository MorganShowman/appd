module Appd
  class App
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def ps
      docker_compose("ps")
    end

    def build(*services)
      docker_compose("build #{services.join(" ")}")
    end

    def up(*services)
      docker_compose("up -d #{services.join(" ")}")
    end

    def stop(*services)
      docker_compose("stop #{services.join(" ")}")
    end

    def restart(*services)
      docker_compose("restart #{services.join(" ")}")
    end

    def exec(service, command)
      docker_compose("exec #{service} #{command}")
    end

    private

    def app_path
      "#{options.app_path || ENV["APP_PATH"]}/#{options.app}"
    end

    def docker_compose(command)
      Appd.exec "direnv exec #{app_path} docker-compose -f #{app_path}/#{options.file} #{command}", server: options.server
    end
  end
end
