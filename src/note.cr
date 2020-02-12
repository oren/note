module Note
  VERSION = "0.1.0"

	notes_file = "./notes"

	if !ARGV.empty?
		notes_file = ARGV[0]
	end

	Process.run(
		ENV["EDITOR"],
		args: {notes_file},
		input: Process::Redirect::Inherit,
		output: Process::Redirect::Inherit,
		error: Process::Redirect::Inherit,
	)
end
