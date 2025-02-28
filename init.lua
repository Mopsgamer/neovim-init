-- Bootstrap lazy.nvim
vim.wo.number = true  -- Enable line numbers
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  { "williamboman/mason.nvim" },  -- LSP Installer
  { "williamboman/mason-lspconfig.nvim" }, -- Mason + lspconfig bridge
  { "neovim/nvim-lspconfig" },    -- LSP support
  { "hrsh7th/nvim-cmp" },         -- Completion plugin
  { "hrsh7th/cmp-nvim-lsp" },     -- LSP completion source
  { "hrsh7th/cmp-buffer" },       -- Buffer completion
  { "hrsh7th/cmp-path" },         -- Path completion
  { "hrsh7th/cmp-cmdline" },      -- Command-line completion
  { "L3MON4D3/LuaSnip" },         -- Snippet engine (needed for cmp)
  { "saadparwaiz1/cmp_luasnip" }  -- Snippet completion
})

-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls" }
})

-- Setup LSP for ts_ls
local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.ts_ls.setup({
  capabilities = capabilities
})

-- Setup Autocompletion
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- Enable snippet expansion
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter to confirm
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- Enable snippets
    { name = "buffer" },
    { name = "path" },
  }),
})

vim.cmd([[colorscheme habamax]])
