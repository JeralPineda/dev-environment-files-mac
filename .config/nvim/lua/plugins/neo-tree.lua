return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- add extension names you want to explicitly exclude
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {".git", ".expo"},
        },
      },
    })
    vim.keymap.set("n", "<leader>ee", ":Neotree toggle<CR>", {desc = "Toggle file explorer" }) -- toggle file explorer
    vim.keymap.set("n", "<leader>ef", ":Neotree filesystem reveal left<CR>", { desc = "Reveal file explorer" }) -- reveal file explorer
    vim.keymap.set("n", "<leader>eb", ":Neotree buffers reveal float<CR>", { desc = "Reveal float file explorer buffers" }) -- reveal float file explorer buffers
  end,
}
