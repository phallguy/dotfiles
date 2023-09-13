local command = "prettierd '${INPUT}' ${--range-start:charStart} ${--range-end:charEnd} ${--tab-width:tabSize} ${--use-tabs:!insertSpaces}"

return {
	formatCanRange = true,
	formatCommand = command,
	formatStdin = true,
	rootMarkers = {
		'.prettierrc',
		'.prettierrc.json',
		'.prettierrc.js',
		'.prettierrc.yml',
		'.prettierrc.yaml',
		'.prettierrc.json5',
		'.prettierrc.mjs',
		'.prettierrc.cjs',
		'.prettierrc.toml',
	},
}
