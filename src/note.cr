require "option_parser"

module Note
  VERSION = "0.1.0"
	date = false

	option_parser = OptionParser.parse do |parser|
		parser.banner = "Note is a notes taking app"

		parser.on "-d", "--date", "Add current date to notes" do
			date = true
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

	notes_file = "./notes"

	if !ARGV.empty?
		notes_file = ARGV[0]
	end

	if date
		if !File.exists?(notes_file)
			File.new(notes_file,"w")
		end

		content = File.read(notes_file)
		# add current date to top of file
		puts Time.local.to_s("%Y-%m-%d")
		exit
	end

	Process.run(
		ENV["EDITOR"],
		args: {notes_file},
		input: Process::Redirect::Inherit,
		output: Process::Redirect::Inherit,
		error: Process::Redirect::Inherit,
	)
end
