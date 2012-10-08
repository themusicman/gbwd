require "gbwd/version"
require "gbwd/cli"
require "gbwd/commands"

module Gbwd
  
	def self.start(command, options)
		commands = Commands.new
		cli = Cli.new(commands)
		cli.run(command, options)
	end

end

