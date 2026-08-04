local M = {
   "neovim/nvim-lspconfig",
   event = { "BufReadPre", "BufNewFile" }
}

local function python_path(root_dir)
    local candidates = {
        root_dir .. "/.venv/bin/python",
        root_dir .. "/venv/bin/python",
    }

    for _, path in ipairs(candidates) do
        if vim.fn.executable(path) == 1 then
            return path
        end
    end

    return vim.fn.exepath("python3")
end
function M.config()
   local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

   vim.lsp.config("rust_analyzer", {
      cmd = { "rust-analyzer" },
      capabilities = cmp_caps,
      root_dir = function(bufnr, on_dir)
         local fname = vim.api.nvim_buf_get_name(bufnr)
         local root = vim.fs.dirname(
            vim.fs.find({ "Cargo.toml", ".git" }, { upward = true, path = fname })[1]
         )
         on_dir(root)
      end,
      settings = {
         ["rust-analyzer"] = {
            cargo = {
               buildScripts = {
                  enable = false,
               },
            },
            procMacro = {
               enable = true,
               ignored = {
                  leptos_macro = {
                     "server",
                  }
               }
            },
            diagnostics = {
               enable = true,
            },
            check = {
               command = "clippy",
               extraArgs = {
                  "--no-deps",
                  "--",
                  "-W", "clippy::nursery",
               },
            },
            lens = {
               enable = false,
            },
         },
      },
   })
   vim.lsp.config("clangd", {
      cmd = {
         "clangd",
         "--background-index",
         "--clang-tidy",
         "--completion-style=detailed",
         "--header-insertion=never",
         "--cross-file-rename",
         "--query-driver=**/usr/bin/clang*,**/usr/local/bin/clang*,**/usr/bin/gcc",
         "--pch-storage=memory",

      },
      capabilities = cmp_caps,
      root_dir = function(bufnr, on_dir)
         local fname = vim.api.nvim_buf_get_name(bufnr)
         local root = vim.fs.root(fname, {
            "compile_commands.json",
            "compile_flags.txt",
            ".clangd",
            ".git",
         })
         on_dir(root or vim.fs.dirname(fname))
      end, 
      settings = {
         -- clangd picks up clang-tidy via --clang-tidy; additional clang-tidy options can be passed
         clangd = {
            diagnostics = { enable = true },
         },
      },
   })
   vim.lsp.config("pylsp", {
      cmd = { "pylsp" },
      capabilities = cmp_caps,
      root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local root = vim.fs.root(fname, {
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              ".git",
          })
          root = root or vim.fs.dirname(fname)
     
          on_dir(root)
      end,
      before_init = function(_, config)
          config.settings = config.settings or {}
          config.settings.pylsp = config.settings.pylsp or {}
          config.settings.pylsp.plugins = config.settings.pylsp.plugins or {}
          if config.root_dir then
              config.settings.pylsp.plugins.jedi = {
                  environment = python_path(config.root_dir),
              }
          end
      end, 
      settings = {
         pylsp = {
            plugins = {
               -- Use Ruff for linting
               ruff = {
                   enabled = true,
                   formatEnabled = false, -- let another formatter handle formatting
                   extendSelect = { "E", "F", "W", "I" },
                   ignore = {},
               },
               pycodestyle = {
                  enabled = true,
               },
               pyflakes = {
                  enabled = true,
               },
               mccabe = {
                  enabled = true,
               },
               autopep8 = {
                  enabled = true,
               },
               yapf = {
                  enabled = true,
               },

               jedi_completion = {
                  fuzzy = true,
               },
               jedi_definition = {
                  enabled = true,
               },
               jedi_hover = {
                  enabled = true,
               },
               jedi_references = {
                  enabled = true,
               },
               jedi_signature_help = {
                  enabled = true,
               },
               jedi_symbols = {
                  enabled = true,
               },
            },
         },
      },
   })
   vim.lsp.config("hls", {
      cmd = { "haskell-language-server-wrapper", "--lsp" },
      capabilities = cmp_caps,
      root_dir = function(bufnr, on_dir)
         local fname = vim.api.nvim_buf_get_name(bufnr)
         local root = vim.fs.root(fname, {
            "cabal.project",
            "stack.yaml",
            "hie.yaml",
            ".git",
         })
         if root then
            on_dir(root)
            return
         end
         local dir = vim.fs.dirname(fname)
         while dir do
            local cabals = vim.fn.globpath(dir, "*.cabal", false, true)
            if #cabals > 0 then
               on_dir(dir)
               return
            end
            local parent = vim.fs.dirname(dir)
            if parent == dir then
               break
            end
            dir = parent
         end
         on_dir(vim.fs.dirname(fname))
      end,
      settings = {
         haskell = {
            formattingProvider = "fourmolu",
            checkProject = true,
            checkParents = "CheckOnSave",
            plugin = {
               stan = {
                  globalOn = true,
               },
               hlint = {
                  globalOn = true,
               },
            },
         },
      },
   })
   vim.lsp.enable("hls")
   vim.lsp.enable("pylsp")
   vim.lsp.enable("clangd")
   vim.lsp.enable("rust_analyzer")
end

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      vim.lsp.inlay_hint.enable(true)
   end,
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = { "c", "cpp", "h", "hpp" },
   callback = function()
      vim.opt_local.shiftwidth = 4
      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = true
   end,
})
vim.diagnostic.config({
   virtual_text = true,
   signs = true,
   underline = true,
   update_in_insert = true,
   severity_sort = true,
})

return M
