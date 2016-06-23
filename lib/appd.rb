require "appd/app"
require "appd/version"

module Appd
  def self.apps_path
    ENV["APPS_PATH"]
  end

  def self.exec(command, options)
    super "#{"source ~/.appd/#{options.server} && " if options.server}direnv exec #{options.apps_path}/#{options.app} #{command}"
  end
end
