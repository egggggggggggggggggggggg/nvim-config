local highlight = vim.api.nvim_set_hl;
local function from_palette(palette, override)
    local highlight_groups = {
        Normal      = { fg = palette.fg, bg = palette.bg0 },
        NormalNC    = { fg = palette.fg, bg = palette.b0 },
        Terminal    = { fg = palette.fg, bg = palette.bg0 },
        EndOfBuffer = { fg = palette.bg0, bg = palette.bg0 },
    }

    for group, config in pairs(highlight_groups) do
        highlight(0, group, config)
    end

    if override ~= nil then
        for group, config in pairs(override) do
            highlight(0, group, config)
        end
    end
end

local palette = {
    -- Core
    bg0            = "#052529",
    fg             = "#D9F3F5",
    grey_blue      = "#B9D9DD",

    -- Primary syntax
    yolk_yellow    = "#FFD83D",
    yellow         = "#FFD83D",
    orange         = "#FF8A4C",
    tan            = "#F2C47D",
    pink           = "#FF79B0",
    mint_green     = "#50F2AA",
    brown_orange   = "#EFA06B",

    -- High contrast punctuation
    br_highlight_0 = "#FFD83D",
    br_highlight_1 = "#E78BFF",
    br_highlight_2 = "#32C7FF",

    purple         = "#A78BFA",
    cyan           = "#29D9E8",

    -- Secondary text
    monotone       = "#6F9BA1",

    -- UI
    bg1            = "#173E45",
    bg2            = "#0A2024",
    bg3            = "#173E45",
    bg4            = "#0A2024",

    bg_red         = "#432A30",
    bg_green       = "#183D30",
    bg_blue        = "#143C48",

    -- Diagnostics / secondary colors
    red            = "#FF6B8A",
    green          = "#67E8A5",
    blue           = "#62B9FF",

    grey           = "#45656A",
    light_grey     = "#72999F",

    light_yellow   = "#FFD28A",
    light_blue     = "#55E8F5",

    none           = "NONE",

    constant_orang = "#FFB52E",

    NEON_GREEN     = "#39FF14",
    white          = "#FFFFFF",
    real_red       = "#FF4D5A",
}local function deep_merge(a, b)
    local result = {}

    for k, v in pairs(a or {}) do
        result[k] = v
    end

    for k, v in pairs(b or {}) do
        if type(v) == "table" and type(result[k]) == "table" then
            result[k] = deep_merge(result[k], v)
        else
            result[k] = v
        end
    end

    return result
end

local function Merge(...)
    local result = {}
    for _, tbl in ipairs { ... } do
        result = deep_merge(result, tbl)
    end
    return result
end


local override = {
    Operator                   = { fg = palette.pink },
    Delimiter                  = { fg = palette.pink },
    SpecialChar                = { fg = palette.white },
    DiagnosticError            = { fg = palette.real_red },
    DiagnosticHint             = { fg = palette.brown_orange },
    DiagnosticInfo             = { fg = palette.light_blue },
    DiagnosticWarn             = { fg = palette.brown_orange },
    DiagnosticFloatingError    = { link = 'DiagnosticError' },
    DiagnosticFloatingHint     = { link = 'DiagnosticHint' },
    DiagnosticFloatingInfo     = { link = 'DiagnosticInfo' },
    DiagnosticFloatingWarn     = { link = 'DiagnosticWarn' },
    DiagnosticSignError        = { link = 'DiagnosticError' },
    DiagnosticSignHint         = { link = 'DiagnosticHint' },
    DiagnosticSignInfo         = { link = 'DiagnosticInfo' },
    DiagnosticSignWarn         = { link = 'DiagnosticWarn' },
    DiagnosticUnderlineError   = { sp = palette.real_red, undercurl = true },
    DiagnosticUnderlineHint    = { sp = palette.brown_orange, undercurl = true },
    DiagnosticUnderlineInfo    = { sp = palette.light_blue, undercurl = true },
    DiagnosticUnderlineWarn    = { sp = palette.brown_orange, undercurl = true },
    DiagnosticVirtualTextError = { fg = palette.real_red, bg = palette.bg },
    DiagnosticVirtualTextHint  = { fg = palette.brown_orange, bg = palette.bg },
    DiagnosticVirtualTextInfo  = { fg = palette.light_blue, bg = palette.bg },
    DiagnosticVirtualTextWarn  = { fg = palette.brown_orange, bg = palette.bg },
    Statement                  = { fg = palette.pink },
    NormalFloat                = { fg = palette.cyan },

}
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#4EC9B0" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#4EC9B0" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#CE9178" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#D7BA7D" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#FFD700" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#B5CEA8" })
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3A3A3A", nocombine = true })
vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#3A3A3A", nocombine = true })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#FFD700" }) -- bright gold for current scope
vim.o.termguicolors = true
vim.cmd("syntax on")
vim.opt.background = "dark"
vim.g.colors_name = "noctis"
-- apply the palette
local rusttheme = {
    ["@lsp.type.namespace.rust"]                = { fg = palette.light_blue, },
    ["@lsp.type.function.rust"]                 = { fg = palette.cyan },
    ["@lsp.mod.public.rust"]                    = { fg = palette.cyan },
    ["@lsp.type.parameter.rust"]                = { fg = palette.tan },
    ["@lsp.typemod.variable.declaration.rust"]  = { fg = palette.tan },
    ["@lsp.typemod.parameter.declaration.rust"] = { fg = palette.tan },
    ["@lsp.type.builtinType.rust"]              = { fg = palette.brown_orange, italic = true },
    ["@lsp.type.macro.rust"]                    = { fg = palette.cyan },
    ["@lsp.type.variable.rust"]                 = { fg = palette.tan },
    ["@lsp.type.property.rust"]                 = { fg = palette.grey_blue },
    ["@lsp.type.struct.rust"]                   = { fg = palette.brown_orange },
    ["@lsp.type.const.rust"]                    = { fg = palette.constant_orang, bold = false },
    ["@lsp.typemod.function.declaration.rust"]  = { fg = palette.cyan },
    ["@lsp.import.rust"]                        = { fg = palette.orange },
    ["@keyword.modifier.rust"]                  = { fg = palette.pink },
    ["@keyword.function.rust"]                  = { fg = palette.orange, bold = true },
    ["@keyword.import.rust"]                    = { fg = palette.orange },
    ["@lsp.type.interface.rust"]                = { fg = palette.brown_orange },
    ["@lsp.type.typeAlias.rust"]                = { fg = palette.brown_orange },
    ["@lsp.type.enumMember.rust"]               = { fg = palette.brown_orange },
    ["@punctuation.bracket.rust"]               = { fg = palette.br_highlight_1 },
    ["@operator.rust"]                          = { fg = palette.br_highlight_2 },
    ["@lsp.type.enum.rust"]                     = { fg = palette.brown_orange },
    ["@lsp.type.method.rust"]                   = { fg = palette.cyan },
    ["@number.float"]                           = { fg = palette.purple },
    ["@number.rust"]                            = { fg = palette.purple },
    ["@boolean.rust"]                           = { fg = palette.purple },
    ["@lsp.type.attributeBracket.rust"]         = { fg = palette.yolk_yellow },
}

local ctheme = {
    -- LSP semantic tokens / treesitter
    ["@lsp.type.namespace.c"]                = { fg = palette.light_blue },
    ["@lsp.type.function.c"]                 = { fg = palette.cyan },
    ["@lsp.mod.public.c"]                    = { fg = palette.cyan },
    ["@lsp.type.parameter.c"]                = { fg = palette.tan },
    ["@lsp.typemod.parameter.declaration.c"] = { fg = palette.tan },
    ["@lsp.type.builtinType.c"]              = { fg = palette.brown_orange, italic = true },
    ["@lsp.type.macro.c"]                    = { fg = palette.cyan },
    ["@lsp.type.variable.c"]                 = { fg = palette.tan },
    ["@lsp.type.property.c"]                 = { fg = palette.grey_blue },
    ["@lsp.type.struct.c"]                   = { fg = palette.brown_orange },
    ["@lsp.type.const.c"]                    = { fg = palette.constant_orang },
    ["@lsp.typemod.function.declaration.c"]  = { fg = palette.cyan },
    ["@lsp.type.enumMember.c"]               = { fg = palette.orange },
    ["@lsp.type.type.c"]                     = { fg = palette.orange },
    ["@lsp.type.class.c"]                    = { fg = palette.orange },
    -- keywords / control
    ["@keyword.modifier.c"]                  = { fg = palette.pink },
    ["@keyword.function.c"]                  = { fg = palette.orange, bold = true },
    ["@keyword.import.c"]                    = { fg = palette.orange },

    -- punctuation / operators
    ["@punctuation.bracket.c"]               = { fg = palette.br_highlight_1 },
    ["@operator.c"]                          = { fg = palette.br_highlight_2 },

    -- numbers / booleans / constants
    ["@number.c"]                            = { fg = palette.purple },
    ["@boolean.c"]                           = { fg = palette.purple },
    ["@constant.builtin.c"]                  = { fg = palette.constant_orang },

    -- preprocessor / includes
    ["@preproc.c"]                           = { fg = palette.yellow },
    ["@include.c"]                           = { fg = palette.orange },

    -- macros and defines
    ["@macro.c"]                             = { fg = palette.cyan },

    -- types / enums / typedefs
    ["@type.c"]                              = { fg = palette.brown_orange },
    ["@type.qualifier.c"]                    = { fg = palette.tan },

    -- struct members / fields
    ["@field.c"]                             = { fg = palette.grey_blue },

    -- function calls vs definitions (treesitter / LSP)
    ["@function.call.c"]                     = { fg = palette.cyan },
    ["@function.definition.c"]               = { fg = palette.cyan },

    -- attributes / annotations
    ["@attribute.c"]                         = { fg = palette.yolk_yellow },

    -- punctuation / delimiters
    Delimiter                                = { fg = palette.pink },
    Operator                                 = { fg = palette.pink },
    -- Diagnostics mapping (reuse your override entries if needed)
    DiagnosticError                          = { fg = palette.real_red },
    DiagnosticHint                           = { fg = palette.brown_orange },
    DiagnosticInfo                           = { fg = palette.light_blue },
    DiagnosticWarn                           = { fg = palette.brown_orange },
}

-- This actually properly works.
local fixed_ctheme = {
    -- LSP semantic tokens / treesitter
    ["@lsp.type.namespace.cpp"]                = { fg = palette.light_blue },
    ["@lsp.type.function.cpp"]                 = { fg = palette.cyan },
    ["@lsp.mod.public.cpp"]                    = { fg = palette.cyan },
    ["@lsp.type.parameter.cpp"]                = { fg = palette.tan },
    ["@lsp.typemod.parameter.declaration.cpp"] = { fg = palette.tan },
    ["@lsp.type.builtinType.cpp"]              = { fg = palette.brown_orange, italic = true },
    ["@lsp.type.macro.cpp"]                    = { fg = palette.cyan },
    ["@lsp.type.variable.cpp"]                 = { fg = palette.tan },
    ["@lsp.type.property.cpp"]                 = { fg = palette.grey_blue },
    ["@lsp.type.struct.cpp"]                   = { fg = palette.brown_orange },
    ["@lsp.type.const.cpp"]                    = { fg = palette.constant_orang },
    ["@lsp.typemod.function.declaration.cpp"]  = { fg = palette.cyan },
    ["@lsp.type.enumMember.cpp"]               = { fg = palette.orange },
    ["@lsp.type.type.cpp"]                     = { fg = palette.orange },
    ["@lsp.type.class.cpp"]                    = { fg = palette.orange },
    -- keywords / control
    ["@keyword.modifier.cpp"]                  = { fg = palette.pink },
    ["@keyword.function.cpp"]                  = { fg = palette.orange, bold = true },
    ["@keyword.import.cpp"]                    = { fg = palette.orange },

    -- punctuation / operators
    ["@punctuation.bracket.cpp"]               = { fg = palette.br_highlight_1 },
    ["@operator.cpp"]                          = { fg = palette.br_highlight_2 },

    -- numbers / booleans / constants
    ["@number.cpp"]                            = { fg = palette.purple },
    ["@boolean.cpp"]                           = { fg = palette.purple },
    ["@constant.builtin.cpp"]                  = { fg = palette.constant_orang },

    -- preprocessor / includes
    ["@preproc.cpp"]                           = { fg = palette.yellow },
    ["@include.cpp"]                           = { fg = palette.orange },

    -- macros and defines
    ["@macro.cpp"]                             = { fg = palette.cyan },

    -- types / enums / typedefs
    ["@type.cpp"]                              = { fg = palette.brown_orange },
    ["@type.qualifier.cpp"]                    = { fg = palette.tan },

    -- struct members / fields
    ["@field.cpp"]                             = { fg = palette.grey_blue },

    -- function calls vs definitions (treesitter / LSP)
    ["@function.call.cpp"]                     = { fg = palette.cyan },
    ["@function.definition.cpp"]               = { fg = palette.cyan },

    -- attributes / annotations
    ["@attribute.cpp"]                         = { fg = palette.yolk_yellow },

    -- punctuation / delimiters
    Delimiter                                = { fg = palette.pink },
    Operator                                 = { fg = palette.pink },
    -- Diagnostics mapping (reuse your override entries if needed)
    DiagnosticError                          = { fg = palette.real_red },
    DiagnosticHint                           = { fg = palette.brown_orange },
    DiagnosticInfo                           = { fg = palette.light_blue },
    DiagnosticWarn                           = { fg = palette.brown_orange },
}


local language_overrides = Merge(override, rusttheme);
from_palette(palette, language_overrides)

local cpp_overrides = Merge(override, fixed_ctheme);
from_palette(palette, cpp_overrides)

local c_overrides = Merge(override, ctheme);
from_palette(palette, c_overrides)

vim.api.nvim_set_hl(0, "Comment", {
    fg = "#caf4fa",
    italic = true,
})

vim.api.nvim_set_hl(0, "@comment", {
    fg = "#caf4fa",
    italic = true,
})

vim.api.nvim_set_hl(0, "LineNr", {
    fg = "#42666B",
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = palette.yolk_yellow,
    bg = "NONE",
    bold = true,
})


local transparent_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "LineNr",
    "Folded",
    "NonText",
    "EndOfBuffer",
    "MsgArea",
    "TelescopeNormal",
    "TelescopeBorder",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "WinBar",
    "WinBarNC",
}

-- for _, group in ipairs(transparent_groups) do
--     vim.api.nvim_set_hl(0, group, {
--         bg = "NONE",
--     })
-- end

vim.api.nvim_set_hl(0, "FloatBorder", {
    fg = palette.cyan,
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "StatusLine", {
    fg = palette.fg,
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "StatusLineNC", {
    fg = palette.monotone,
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "WinBar", {
    fg = palette.grey_blue,
    bg = "NONE",
})

vim.api.nvim_set_hl(0, "Pmenu", {
    fg = palette.fg,
    bg = "#0A2024",
})

vim.api.nvim_set_hl(0, "PmenuSel", {
    fg = "#FFFFFF",
    bg = "#174A52",
    bold = true,
})
