module Note
  VERSION = "0.1.0"

	# Process.run(ENV["EDITOR"], args: {"myfile.txt"})

	stdout = IO::Memory.new
	stderr = IO::Memory.new

	Process.run("vim", args: {"/tmp/myfile.txt"}, output: stdout, error: stderr)
end
