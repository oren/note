module Note
  VERSION = "0.1.0"

	Process.run(
		ENV["EDITOR"],
		args: {"myfile.txt"},
		input: Process::Redirect::Inherit,
		output: Process::Redirect::Inherit,
		error: Process::Redirect::Inherit,
	)
end
