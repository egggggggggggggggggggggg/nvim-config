require "opts"
require "launch"
require("plugin.colortheme")

vim = vim
-- search functionality
spec("plugin.telescope")
spec("plugin.harpoon")

-- QoL stuff
spec("plugin.lualine")
spec("plugin.nvim-scrollbar")
spec("plugin.toggleterm")
spec("plugin.nvim-autopairs")
spec("plugin.nvim-tree")
spec("plugin.screenkey")
-- spec("plugin.fidget")
spec("plugin.better-diag")
-- spec("plugin.multicursor")
--probably not worth using for a minor visual improvement
-- spec("plugin.noice")
--
-- lsp related stuff
spec("plugin.cmp")
spec("plugin.treesitter")
spec("plugin.lspconfig")
vim.cmd("highlight! IblIndent guifg=#5c4a72 gui=nocombine")
vim.cmd("highlight! IblWhitespace guifg=#d16cbd gui=nocombine")
vim.cmd("highlight! IblScope guifg=#B22222 gui=nocombine")

require "plugin.lazy"
require "keymaps"
