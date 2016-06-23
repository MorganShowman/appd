require "appd/app"
require "appd/version"

module Appd
  APPD_CONFIG_PATH = File.expand_path("~/.appd")

  def self.initialize!
    Dir.mkdir(APPD_CONFIG_PATH) if !File.directory?(APPD_CONFIG_PATH)

    Dir.mkdir("#{APPD_CONFIG_PATH}/envs") if !File.directory?("#{APPD_CONFIG_PATH}/envs")
    Dir.mkdir("#{APPD_CONFIG_PATH}/servers") if !File.directory?("#{APPD_CONFIG_PATH}/servers")

    File.write("#{APPD_CONFIG_PATH}/current-server") if !File.file?("#{APPD_CONFIG_PATH}/current-server")
    File.write("#{APPD_CONFIG_PATH}/current-env") if !File.file?("#{APPD_CONFIG_PATH}/current-env")

    ENV.replace(eval(`#{ENV["SHELL"]} -c \"source ~/.appd/current-env && ruby -e 'p ENV'\"`))
  end

  def self.apps_path
    ENV["APPS_PATH"]
  end

  def self.env(name)
    if File.file?("#{APPD_CONFIG_PATH}/envs/#{name}")
      print "Selecting the #{name} ENV file..."
      File.open("#{APPD_CONFIG_PATH}/current-env", "w") { |f| f.write("source ~/.appd/envs/#{name}") }
      puts "Done!"
    else
      puts "There is no ENV file at ~/.appd/env/#{name}..."
    end
  end

  def self.exec(command, options)
    commands = []
    commands << "source ~/.appd/#{options.server ? "servers/#{options.server}" : "current-server"}"
    commands << "direnv exec #{options.apps_path}/#{options.app} #{command}"

    super commands.join(" && ")
  end

  def self.select(server)
    if File.file?("#{APPD_CONFIG_PATH}/servers/#{server}")
      print "Selecting the #{server} Docker Server ENV file..."
      File.open("#{APPD_CONFIG_PATH}/current-server", "w") { |f| f.write("source ~/.appd/servers/#{server}") }
      puts "Done!"
    else
      puts "There is no Docker Server ENV at ~/.appd/servers/#{server}..."
    end
  end
end
