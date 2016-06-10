require "appd/app"
require "appd/version"

module Appd
  def self.docker_select(server)
    puts `source ~/.appd/#{server}`
  end

  def self.exec(command)
    super command
  end
end
