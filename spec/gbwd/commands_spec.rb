require 'spec_helper'

describe Gbwd::Commands, fakefs: true do
	
	before do
	    FileUtils.mkdir("/etc")
	    File.open("/etc/hosts", "w") do |f|
			f.puts("##")
			f.puts("# Host Database")
			f.puts("#")
			f.puts("# localhost is used to configure the loopback interface")
			f.puts("# when the system is booting.  Do not change this entry.")
			f.puts("##")
			f.puts("127.0.0.1	localhost")
			f.puts("255.255.255.255	broadcasthost")
			f.puts("::1             localhost")
			f.puts("fe80::1%lo0	localhost")
			f.puts("\n")
			f.puts("\n")
			f.puts("# VHX START")
			f.puts("127.0.0.1 test.dev")
			f.puts("fe80::1%lo0 test.dev")
			f.puts("# VHX STOP")
	    end
  	end
	
	it "#add should add a domain to the hosts file" do
		commands = Gbwd::Commands.new
		commands.add({domain: 'www.youtube.com'})
		file = File.open("/etc/hosts", 'r').read
		file.match(/www.youtube.com/m).should_not eq(nil)
	end

	it "#remove should remove a domain to the hosts file" do
		commands = Gbwd::Commands.new
		commands.add({domain: 'www.youtube.com'})
		commands.remove({domain: 'www.youtube.com'})
		file = File.open("/etc/hosts", 'r').read
		file.match(/www.youtube.com/m).should eq(nil)
	end

	it "#list should return a list of all domains" do
		commands = Gbwd::Commands.new
		commands.add({domain: 'www.youtube.com'})
		commands.add({domain: 'www.facebook.com'})
		commands.list.should eq("The following domains are currenlty being blocked:\nwww.youtube.com\nwww.facebook.com")
	end

	it "#disable should comment out all lines" do
		commands = Gbwd::Commands.new
		commands.add({domain: 'www.youtube.com'})
		commands.add({domain: 'www.facebook.com'})
		commands.disable({})
		file = File.open("/etc/hosts", 'r').read
		matches = file.match(/#-GBWD START(.*)#-GBWD END/m)
		unless matches.nil?
			matches.captures[0].split("\n").each do |domain|
				unless domain.empty?
					domain.start_with?('#').should eq(true)
				end
			end
		else
			raise 'No domains found'
		end
	end

	it "#enable should uncomment all lines" do
		commands = Gbwd::Commands.new
		commands.add({domain: 'www.youtube.com'})
		commands.add({domain: 'www.facebook.com'})
		commands.disable({})
		commands.enable({})
		file = File.open("/etc/hosts", 'r').read
		matches = file.match(/#-GBWD START(.*)#-GBWD END/m)
		unless matches.nil?
			matches.captures[0].split("\n").each do |domain|
				unless domain.empty?
					domain.start_with?('#').should_not eq(true)
				end
			end
		else
			raise 'No domains found'
		end
	end
	
end