require "option_parser"
require "system/user"
require "json"

class Note
  VERSION = "0.1.0"
	@date = false
	@notes_file = "./notes"
	@config_file = "#{Path.home}/.config/note/config.json"

	def run
		option_parser = OptionParser.parse do |parser|
			parser.banner = "Note is a notes taking app"

			parser.on "-d", "--date", "Add current date to notes" do
				@date = true
			end
			parser.on "-v", "--version", "Show version" do
				puts "version 1.0"
				exit
			end
			parser.on "-h", "--help", "Show help" do
				puts parser
				exit
			end
		end


		if File.exists?(@config_file)
			config = File.read(@config_file)
			con =  JSON.parse(config)

			if con["note_location"]
				@notes_file = con["note_location"].to_s
			end
		else
			p "This is the first time you are running the app. Choose location for your notes"
			user_input = gets
			@notes_file = user_input.to_s
		end

		open_vim

		if !ARGV.empty?
			@notes_file = ARGV[0]
		end

		# add current date to top of file
		if @date
			content = ""
			if File.exists?(@notes_file)
				content = File.read(@notes_file)
			end
			File.write(@notes_file, Time.local.to_s("%Y-%m-%d") + "\n\n" + content)
		end
	end

	def open_vim
		Process.run(
			ENV["EDITOR"],
			args: {@notes_file},
			input: Process::Redirect::Inherit,
			output: Process::Redirect::Inherit,
			error: Process::Redirect::Inherit,
		)
	end
end

Note.new.run
