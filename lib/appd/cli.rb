require "thor"

module Appd
  class CLI < Thor
    class_option :app_path, type: :string, hide: true
    class_option :app, type: :string, hide: true, required: ARGV.count > 0 &&
                                                              ARGV[0] != 'help' &&
                                                              ARGV[0] != "."
    class_option :server, type: :string, aliases: "-s", desc: "Specify a docker server env file"

    default_task :help

    desc "help", "Show this help"
    def help
      puts "Usage:"
      puts "  appd APPNAME command\n\n"
      puts "Commands:"
      self.class.commands.each { |_, command| printf "%-30s %s\n", "  #{command.usage} ", "# #{command.description}" }
      puts "\nNote: appd looks for apps in the $APP_PATH directory."
      puts "      APPNAME can be . for current app."
    end

    desc "ps", "List containers"
    def ps
      app.ps
    end

    desc "build SERVICES", "Build or rebuild services"
    def build(*services)
      app.build(*services)
    end

    desc "up SERVICES", "Create and start services"
    def up(*services)
      app.up(*services)
    end

    desc "stop SERVICES", "Stop services"
    def stop(*services)
      app.stop(*services)
    end

    desc "restart SERVICES", "Restart services"
    def restart(*services)
      app.restart(*services)
    end

    desc "exec SERVICE -c \"COMMAND\"", "Execute a command in a running container"
    option :command, type: :string, aliases: "-s", required: true
    def exec(service)
      app.exec(service, options.command)
    end

    private

    no_tasks do
      def app
        Appd::App.new(options)
      end
    end
  end
end
