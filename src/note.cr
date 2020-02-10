module Note
  VERSION = "0.1.0"
	puts ARGV

	Process.run(
		ENV["EDITOR"],
		ARGV,
		input: Process::Redirect::Inherit,
		output: Process::Redirect::Inherit,
		error: Process::Redirect::Inherit,
	)
end
