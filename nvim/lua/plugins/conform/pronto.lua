return {
	command = "pronto",
	args = {
		"--workdir",
		"--exit-code",
		"--runner rubocop"
		"$FILENAME",
	},
	exit_codes = { 0, 1 },
}
