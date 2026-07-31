return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}
    end,
    keys = {
      {
        "<leader>aa",
        function()
          require("opencode").ask("@this: ")
        end,
        mode = { "n", "x" },
        desc = "Ask OpenCode",
      },
      {
        "<leader>as",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Select OpenCode action",
      },
      {
        "<leader>ao",
        function()
          return require("opencode").operator("@this ")
        end,
        mode = { "n", "x" },
        expr = true,
        desc = "Add range to OpenCode",
      },
      {
        "<leader>aO",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        expr = true,
        desc = "Add line to OpenCode",
      },
      {
        "<leader>au",
        function()
          require("opencode").command("session.half.page.up")
        end,
        desc = "Scroll OpenCode up",
      },
      {
        "<leader>ad",
        function()
          require("opencode").command("session.half.page.down")
        end,
        desc = "Scroll OpenCode down",
      },
    },
  },
}
