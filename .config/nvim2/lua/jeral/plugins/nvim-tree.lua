return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = true,
        },
        icons = {
          show = { folder_arrow = false, git = true },
          glyphs = {
            git = {
              unstaged = "~", -- "✗"
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store", "^.git$" },
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,  -- Muestra el estado de Git en directorios
        show_on_open_dirs = true, -- Muestra el estado al abrir directorios
        timeout = 500,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer


    -- Define los colores de Git como en VS Code
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#e5c07b" })   -- Modificado
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#98c379" })     -- Agregado
    vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#e06c75" }) -- Eliminado
    vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#61afef" })  -- Preparado (staged)
    vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { fg = "#c678dd" })   -- Conflicto
    vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { fg = "#56b6c2" }) -- Renombrado
  end
}
