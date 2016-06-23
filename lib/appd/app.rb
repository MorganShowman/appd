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

    def docker_compose_file
      "#{options.apps_path}/#{options.app}/#{options.file}"
    end

    def docker_compose(command)
      Appd.exec "docker-compose -f #{docker_compose_file} #{command}", options
    end
  end
end
