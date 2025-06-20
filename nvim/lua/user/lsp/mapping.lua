if vim.g.vscode then
	return
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
		vim.keymap.set("n", "gd", function()
			require("snacks").picker.lsp_definitions()
		end, { buffer = bufnr })
		-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
		vim.keymap.set("n", "gD", function()
			require("snacks").picker.lsp_definitions({
				auto_confirm = false,
			})
		end, { buffer = bufnr })

		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help", buffer = bufnr })

		vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "[L]ine diagnostics", buffer = bufnr })
		vim.keymap.set("n", "lf", require("snacks").picker.lsp_symbols, { desc = "Document symbols", buffer = bufnr })

		vim.keymap.set("n", "<space>lr", vim.lsp.buf.rename, { buffer = bufnr })
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr })
		vim.keymap.set("n", "<leader>lu", vim.lsp.buf.references, { buffer = bufnr })
		vim.keymap.set("n", "<leader>li", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
		end, { buffer = bufnr })

		-- Show line diagnostics automatically in hover window
		-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		-- 	callback = function()
		-- 		vim.diagnostic.open_float(nil, { focus = false })
		-- 	end,
		-- })

		if client.supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		-- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end,
})
