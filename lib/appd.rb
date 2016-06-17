require "appd/app"
require "appd/version"

module Appd
  def self.exec(command, **options)
    super "#{"source ~/.appd/#{options[:server]} && " if options[:server]}#{command}"
  end
end
