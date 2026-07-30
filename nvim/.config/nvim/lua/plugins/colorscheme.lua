return {
  -- prev tokyo night theme:
  -- { "folke/tokyonight.nvim" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "tokyonight",
  --   },
  -- },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        once = true,
        callback = function()
          vim.cmd.colorscheme("catppuccin")
        end,
      })
    end,
    opts = {
      -- flavour = "macchiato",
      -- flavour = "frappe",
      flavour = "mocha",
      custom_highlights = function(colors)
        return {
          NormalFloat = { bg = colors.crust },
          FloatBorder = { fg = colors.text, bg = colors.crust },
          FloatTitle = { fg = colors.text, bg = colors.crust },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
