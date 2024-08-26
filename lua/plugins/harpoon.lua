return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Add File to Harpoon' })
    vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = 'Toggle Harpoon Menu' })

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end, { desc = 'Nav: File 1 (Harpoon)' })
    vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end, { desc = 'Nav: File 2 (Harpoon)' })
    vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end, { desc = 'Nav: File 3 (Harpoon)' })
    vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end, { desc = 'Nav: File 4 (Harpoon)' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end
}
