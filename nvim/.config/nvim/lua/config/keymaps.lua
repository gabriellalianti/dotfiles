-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MarkdownPreview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "Start Markdown Preview" })
vim.keymap.set("n", "<leader>mps", "<cmd>MarkdownPreviewStop<CR>", { desc = "Stop Markdown Preview" })
