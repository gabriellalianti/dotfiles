local opencode_cmd = "opencode --port"
local terminal_opts = {
  win = {
    position = "right",
    enter = false,
  },
}

return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, terminal_opts)
          end,
        },
      }
    end,
    keys = {
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ")
        end,
        mode = { "n", "x" },
        desc = "Ask OpenCode",
      },
      {
        "<leader>os",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Select OpenCode action",
      },
      {
        "<leader>oo",
        function()
          return require("opencode").operator("@this ")
        end,
        mode = { "n", "x" },
        expr = true,
        desc = "Add range to OpenCode",
      },
      {
        "<leader>oO",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        expr = true,
        desc = "Add line to OpenCode",
      },
      {
        "<leader>ou",
        function()
          require("opencode").command("session.half.page.up")
        end,
        desc = "Scroll OpenCode up",
      },
      {
        "<leader>od",
        function()
          require("opencode").command("session.half.page.down")
        end,
        desc = "Scroll OpenCode down",
      },
      {
        "<leader>ot",
        function()
          require("snacks.terminal").toggle(opencode_cmd, terminal_opts)
        end,
        desc = "Toggle OpenCode sidebar",
      },
    },
  },
}
