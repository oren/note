require "option_parser"
require "system/user"
require "json"

class Note
  VERSION = "0.1.0"
	@date = false
	@notes_file_path = "./notes"
	@config_file_path = "#{Path.home}/.config/note/config.json"

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


		if File.exists?(@config_file_path)
			config = File.read(@config_file_path)

			con = ""
			begin
				con =  JSON.parse(config)
			rescue ex
				p "Error trying to parse the config file. #{ex.message}"
				exit
			end

			if con["note_location"]
				@notes_file_path = con["note_location"].to_s
			end
		else
			p "This is the first time you are running the app. Choose location for your notes"
			user_input = gets
			@config_file_path = user_input.to_s

			# File.write(@config_file_path, {"note_location": "foo"}.to_json, mode: "w")

			File.open(@config_file_path, "w") do |file|
				{"note_location": "foo"}.to_json file
			end
		end

		# add current date to top of file
		if @date
			content = ""
			if File.exists?(@notes_file_path)
				content = File.read(@notes_file_path)
			end
			File.write(@notes_file_path, Time.local.to_s("%Y-%m-%d") + "\n\n" + content)
		end

		open_vim
	end

	def open_vim
		Process.run(
			ENV["EDITOR"],
			args: {@notes_file_path},
			input: Process::Redirect::Inherit,
			output: Process::Redirect::Inherit,
			error: Process::Redirect::Inherit,
		)
	end
end

Note.new.run
