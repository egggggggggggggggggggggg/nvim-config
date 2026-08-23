vim.g.mapleader = " "
vim.o.autowriteall = false
vim.o.winborder = 'rounded'
vim.opt.cindent = true
vim.api.nvim_create_autocmd("BufWritePre", {
   pattern = {"*.rs", "*.c", "*.h", "*.cpp", "*.hpp", ".cc"},
   callback = function()
      vim.lsp.buf.format({ async = false })
   end,
})


vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.iskeyword:remove('.')
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50
vim.opt.swapfile = false
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.colorcolumn = ""
if vim.loop.os_uname().sysname == "Windows_NT" then
   vim.opt.undodir = os.getenv("UserProfile") .. "\\.vim\\undodir"
   vim.opt.shell = "powershell"

   vim.opt.shellcmdflag = "-NoLogo -NoExit -NoProfile -ExecutionPolicy RemoteSigned -Command"
else
   vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end

-- vscode mimic settings

vim.opt.virtualedit = "onemore"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.iskeyword:append("-")

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.clipboard = "unnamedplus"
-- Prevent the go back and ahead stuff from accessing previous directory stuff.
vim.opt.shada = ""
vim.api.nvim_set_hl(0, "CmpGhostText", {
   link = "Comment",
   default = true,
})
