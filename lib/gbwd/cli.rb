module Gbwd
  
	class Cli

		def initialize(commands)
			@commands = commands
		end

		def commands
			@commands
		end

		def run(command, options)
			commands.public_send(command.to_sym, options)
		end

	end
	  
end
