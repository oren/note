module Note
  VERSION = "0.1.0"
	puts ARGV

	file = "/home/oren/m/notes"

	if !ARGV.empty?
		file = ARGV[0]
	end

	Process.run(
		ENV["EDITOR"],
		args: {file},
		input: Process::Redirect::Inherit,
		output: Process::Redirect::Inherit,
		error: Process::Redirect::Inherit,
	)
end
