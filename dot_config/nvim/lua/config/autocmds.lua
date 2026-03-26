local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
	group = augroup("trim_whitespace", { clear = true }),
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- Return to last edit position
autocmd("BufReadPost", {
	group = augroup("last_position", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- 2-space indent for certain filetypes
autocmd("FileType", {
	group = augroup("indent_2", { clear = true }),
	pattern = { "lua", "json", "yaml", "javascript", "typescript", "typescriptreact", "html", "css" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})
