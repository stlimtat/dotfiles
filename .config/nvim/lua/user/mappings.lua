return {
  n = {
    -- resize with arrows
    -- ["<A-k>"] = { function() require("smart-splits").resize_up(2) end, desc = "Resize split up" },
    -- ["<A-j>"] = { function() require("smart-splits").resize_down(2) end, desc = "Resize split down" },
    -- ["<A-h>"] = { function() require("smart-splits").resize_left(2) end, desc = "Resize split left" },
    -- ["<A-l>"] = { function() require("smart-splits").resize_right(2) end, desc = "Resize split right" },
    -- navigating wrapped lines
    j = { "gj", desc = "Navigate down" },
    k = { "gk", desc = "Navigate down" },
    -- easy splits
    ["\\"] = { "<cmd>split<cr>", desc = "Horizontal split" },
    ["|"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },
    -- better increment/decrement
    ["-"] = { "<c-x>", desc = "Descrement number" },
    ["+"] = { "<c-a>", desc = "Increment number" },
    -- Treesitter Surfer
    ["<c-down>"] = { "<cmd>STSSwapDownNormal<cr>", desc = "Swap next tree-sitter object" },
    ["<c-right>"] = { "<cmd>STSSwapDownNormal<cr>", desc = "Swap next tree-sitter object" },
    ["<c-up>"] = { "<cmd>STSSwapUpNormal<cr>", desc = "Swap previous tree-sitter object" },
    ["<c-left>"] = { "<cmd>STSSwapUpNormal<cr>", desc = "Swap previous tree-sitter object" },
    -- Git Conflict
    ["Cc"] = { "<Plug>(git-conflict-ours)", desc = "Take Current" },
    ["Ci"] = { "<Plug>(git-conflict-theirs)", desc = "Take Incoming" },
    ["Cb"] = { "<Plug>(git-conflict-both)", desc = "Take Both" },
    ["C0"] = { "<Plug>(git-conflict-none)", desc = "Take None" },
    ["Cr"] = { "<cmd>GitConflictRefresh<cr>", desc = "Refresh Conflicts" },
    ["Cl"] = { "<cmd>GitConflictListQf<cr>", desc = "List Conflicts" },
    ["]C"] = { "<Plug>(git-conflict-next-conflict)", desc = "Next conflict" },
    ["[C"] = { "<Plug>(git-conflict-prev-conflict)", desc = "Previous conflict" },
  },
  i = {
    -- type template string
    -- [";mk"] = { "<++>", desc = "Insert template string" },
    ["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },
  },
  v = {
    -- navigating wrapped lines
    j = { "gj", desc = "Navigate down" },
    k = { "gk", desc = "Navigate down" },
  },
  -- terminal mappings
  t = {
    -- ["<esc>"] = false,
    -- ["jk"] = false,
    ["<c-q>"] = { "<c-\\><c-n>", desc = "Terminal normal mode" },
    ["<esc><esc>"] = { "<c-\\><c-n>:q<cr>", desc = "Terminal quit" },
  },
  x = {
    -- better increment/decrement
    ["+"] = { "g<c-a>", desc = "Increment number" },
    ["-"] = { "g<c-x>", desc = "Descrement number" },
    -- line text-objects
    ["il"] = { "g_o^", desc = "Inside line text object" },
    ["al"] = { "$o^", desc = "Around line text object" },
    -- Tressitter Surfer
    ["J"] = { "<cmd>STSSelectNextSiblingNode<cr>", desc = "Surf next tree-sitter object" },
    ["K"] = { "<cmd>STSSelectPrevSiblingNode<cr>", desc = "Surf previous tree-sitter object" },
    ["H"] = { "<cmd>STSSelectParentNode<cr>", desc = "Surf parent tree-sitter object" },
    ["L"] = { "<cmd>STSSelectChildNode<cr>", desc = "Surf child tree-sitter object" },
    ["<c-j>"] = { "<cmd>STSSwapNextVisual<cr>", desc = "Surf next tree-sitter object" },
    ["<c-l>"] = { "<cmd>STSSwapNextVisual<cr>", desc = "Surf next tree-sitter object" },
    ["<c-k>"] = { "<cmd>STSSwapPrevVisual<cr>", desc = "Surf previous tree-sitter object" },
    ["<c-h>"] = { "<cmd>STSSwapPrevVisual<cr>", desc = "Surf previous tree-sitter object" },
  },
  o = {
    -- line text-objects
    ["il"] = { ":normal vil<cr>", desc = "Inside line text object" },
    ["al"] = { ":normal val<cr>", desc = "Around line text object" },
  },
  -- [""] = {
  --   ["<c-e><c-e>"] = { "<Plug>SendLine", desc = "Send line to REPL" },
  --   ["<c-e>"] = { "<Plug>Send", desc = "Send to REPL" },
  -- },
}
