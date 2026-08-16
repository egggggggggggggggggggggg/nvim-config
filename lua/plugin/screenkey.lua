return {
  "NStefan002/screenkey.nvim",
  lazy = false,
  version = "*",
      opts = {
         win_opts = {
         relative = "editor",
         anchor = "SE",
         row = -1,
         col = vim.o.columns - 1,
         width = 45,
         height = 3,
         border = "rounded",
      },
   },
}
