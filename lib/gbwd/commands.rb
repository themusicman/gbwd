module Gbwd
  
	class Commands

		def initialize
			@hosts_file_path = '/etc/hosts'
			@ip_address = '69.55.54.215'
		end	

		def add(options = {})
			modify(options) do |domains, domain|
				domains << [ip_address, domain].join(' ')
				"You added #{domain}."
			end
		end

		def remove(options = {})
			modify(options) do |domains, domain|
				domains.select! do |domain_to_check|
					(Regexp.new(domain) =~ domain_to_check).nil?
				end
				"You removed #{domain}."
			end
		end

		def enable(options = {})
			modify(options) do |domains, domain|
				domains.map! do |line|
					if line.start_with?('#')
						line[1..-1] 
					else
						line
					end
				end
				"All domains have been enabled."
			end
		end

		def disable(options = {})
			modify(options) do |domains, domain|
				domains.map! do |line|
					unless line.start_with?('#')
						"#" + line 
					else
						line 
					end
				end
				"All domains have been disabled."
			end
		end

		def list(options = {})
			install unless installed?
			domains = get_domains_from_file
			if domains.size == 0
				[
					"You do not have any blocked domains. You can add one by using the add command.",
					"  ex. ~ sudo gbwd add -d www.youtube.com"	
				].join("\n")
			else
				domains = domains.map do |line|
					line.split(' ')[1]
				end
				"The following domains are currenlty being blocked:\n" + domains.join("\n")
			end
		end

	private

		def modify(options)
			raise ArgumentError.new('You must pass a block to the modify method.') unless block_given?
			install unless installed?
			domain = options.fetch(:domain, nil)
			domains = get_domains_from_file
			response = yield(domains, domain)
			write_to_hosts_file(domains)
			response
		end

		def hosts_file_path
			@hosts_file_path
		end

		def ip_address
			@ip_address
		end

		def get_domains_from_file
			file = File.open(hosts_file_path, 'r').read
			matches = file.match(/#-GBWD START(.*)#-GBWD END/m)
			domains = []
			unless matches.nil?
				matches.captures[0].split("\n").each do |domain|
					unless domain.empty?
						domains << domain
					end
				end
			end
			domains
		end

		def wrap_with_header_and_footer(lines)
			lines.insert(0, '#-GBWD START')
			lines << '#-GBWD END'
		end

		def write_to_hosts_file(lines)
			updated_content = wrap_with_header_and_footer(lines).join("\n")
			file = File.open(hosts_file_path, 'r').read
			updated_file = file.gsub(/#-GBWD START.*#-GBWD END/m, updated_content)
			File.open(hosts_file_path, 'w').write(updated_file)
		end

		def installed?
			file = File.open(hosts_file_path, 'r').read 
			(file.match(/#-GBWD START/)) ? true : false
		end

		def install
			File.open(hosts_file_path, 'a+') do |file|
				file.puts("#-GBWD START\n#-GBWD END")
			end
		end

	end

end
