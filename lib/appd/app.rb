module Appd
  class App
    attr_reader :name

    def initialize(name)
      @name = name
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

    def docker_compose(command)
      puts `direnv exec $APP_PATH/#{name} docker-compose -f $APP_PATH/#{name}/docker-compose.yml #{command}`
    end
  end
end
