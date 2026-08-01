return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette("mocha")
      local mode_colors = {
        n = colors.blue,
        i = colors.green,
        v = colors.mauve,
        V = colors.mauve,
        ["\22"] = colors.mauve,
        c = colors.peach,
        R = colors.red,
        r = colors.red,
        t = colors.green,
      }

      opts.options.theme = require("catppuccin.utils.lualine")("mocha")
      opts.options.section_separators = { left = "", right = "" }
      opts.sections.lualine_a = {
        {
          "mode",
          separator = { right = "" },
          color = function()
            return {
              bg = mode_colors[vim.fn.mode(1):sub(1, 1)] or colors.blue,
              fg = colors.base,
              gui = "bold",
            }
          end,
        },
      }
      opts.sections.lualine_z = {}
    end,
  },
}
