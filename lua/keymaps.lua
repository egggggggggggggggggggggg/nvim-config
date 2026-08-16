vim.g.mapleader = " "
-- vim.keymap.set('n', '<leader>tt', ':bnext<CR>', { desc = 'Go to next buffer (e.g., terminal)' })
-- go back to pre existing terminal
vim.keymap.set('n', '<leader>te', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
-- telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
-- vim.keymap.set("n", "<C-g>", builtin.git_files)
vim.keymap.set("n", "<leader>dd", function()
   require("telescope.builtin").diagnostics({
      sort_by = "severity", -- sort by severity (errors first)
   })
end, { desc = "Diagnostics (sorted by severity)" })
vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find word (project)" })
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Find word (buffer)" })
vim.keymap.set("n", "<leader>fc", function()
   builtin.live_grep({ default_text = vim.fn.expand("<cword>") })
end, { desc = "Find word under cursor" })

vim.keymap.set("n", "<leader>hi", function()
   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)


local term = require("harpoon.term")

-- init.lua
vim.keymap.set('n', '<C-a>', '<C-w>h')
vim.keymap.set('n', '<C-x>', '<C-w>j')
vim.keymap.set('n', '<C-e>', '<C-w>k')
vim.keymap.set('n', '<C-d>', '<C-w>l')

vim.keymap.set("n", "<C-t>", function() term.gotoTerminal(1) end)
local function save_and_quit()
   -- Ensure buffer is valid
   if not vim.api.nvim_get_current_buf() then
      vim.notify("No active buffer", vim.log.levels.ERROR)
      return
   end

   local function safe_cmd(cmd)
      local ok, err = pcall(vim.cmd, cmd)
      if not ok then
         vim.notify("Command failed: " .. cmd .. "\n" .. err, vim.log.levels.ERROR)
      end
      return ok
   end

   if vim.bo.modified then
      local choice = vim.fn.confirm(
         "Save changes before quitting?",
         "&Yes\n&No\n&Cancel",
         1
      )

      if choice == 1 then
         if safe_cmd("write") then
            safe_cmd("quit")
         end
      elseif choice == 2 then
         safe_cmd("quit!")
      else
         return
      end
   else
      safe_cmd("quit")
   end
end
-- quit and write.
vim.keymap.set("n", "<leader>qw", save_and_quit, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qq", vim.cmd.quit, { silent = true })
vim.keymap.set("n", "<leader>rr", vim.cmd.vsplit, { silent = true })
vim.keymap.set("n", "<leader>ss", vim.cmd.split, { silent = true });

-- undotree keymaps
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<C-Up>", "5k")
vim.keymap.set("n", "<C-Down>", "5j")
vim.keymap.set("n", "<C-Left>", "b")
vim.keymap.set("n", "<C-Right>", "w")
local function hover()
   vim.lsp.buf.hover({

   })
end

vim.keymap.set("n", "<leader>df", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>da", hover)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>re", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ch", vim.lsp.buf.signature_help)


-- gen keymaps
-- nvim branch keymaps
vim.keymap.set('n', '<leader><Tab>', '<cmd>NvimTreeToggle<CR>')


vim.keymap.set('n', "<leader>sk", '<cmd>Screenkey<CR>')

-- stupid personal preference stuff
vim.keymap.set('n', "<C-s>", vim.cmd.write, { silent = true })

--markdown notes taking
-- vim.keymap.set('n', "<leader>md", ':MarkdownPreview<CR>')
-- vim.keymap.set('n', "<leader>cd", ':MarkdownPreviewStop<CR>')
-- vim.keymap.set("n", "<leader>pp", builtin.find_files, { desc = "Find files" })


vim.keymap.set("n", "<leader>at", "<C-^>")
vim.keymap.set("n", "<leader>er", "<C-o>")
vim.keymap.set("n", "<leader>we", "<C-i>")
