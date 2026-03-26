return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>h", group = "Git hunks" },
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Diagnostics" },
			{ "<leader>r", group = "Rename" },
		},
	},
}
