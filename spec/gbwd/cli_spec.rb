require 'spec_helper'

describe Gbwd::Cli do
	
	it "#run should call the appropriate sub command when passed a command" do
		commands = double("Commands")
		commands.should_receive(:add)
		cli = Gbwd::Cli.new(commands)
		options = double("options")
		cli.run('add', options)
	end

end