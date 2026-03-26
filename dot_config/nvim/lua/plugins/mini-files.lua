return {
	"echasnovski/mini.files",
	keys = {
		{
			"<leader>e",
			function()
				local mf = require("mini.files")
				if not mf.close() then
					mf.open(vim.api.nvim_buf_get_name(0))
				end
			end,
			desc = "File explorer (current file)",
		},
		{
			"<leader>E",
			function()
				local mf = require("mini.files")
				if not mf.close() then
					mf.open(vim.uv.cwd())
				end
			end,
			desc = "File explorer (cwd)",
		},
	},
	opts = {
		mappings = {
			go_in = "l",
			go_in_plus = "<CR>",
			go_out = "h",
			go_out_plus = "H",
			synchronize = "=",
			show_help = "g?",
		},
		windows = {
			preview = true,
			width_preview = 40,
		},
		options = {
			use_as_default_explorer = true,
		},
	},
}
