require "appd/app"
require "appd/version"

module Appd
  def self.apps_path
    ENV["APPS_PATH"]
  end

  def self.exec(command, options)
    super "source ~/.appd/#{options.server ? options.server : "current-server"} && direnv exec #{options.apps_path}/#{options.app} #{command}"
  end

  def self.select(server)
    if File.file?("#{APPD_PATH}/#{server}")
      print "Selecting the #{server} Docker Server ENV file..."
      File.open("#{APPD_PATH}/current-server", "w") { |f| f.write("source ~/.appd/#{server}") }
      puts "Done!"
    else
      puts "There is no Docker Server ENV file for #{server}..."
    end
  end
end
