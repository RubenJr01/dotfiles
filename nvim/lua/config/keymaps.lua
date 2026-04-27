-- ============================================================
-- config/keymaps.lua — Global keybindings
-- ============================================================

local map = vim.keymap.set

-- ── Better defaults ──────────────────────────────────────────
-- Stay in indent mode when indenting in visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered on jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Don't yank on paste over selection
map("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Delete without yanking
map({ "n", "v" }, "<leader>d", [["_d]])

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ── Window navigation ─────────────────────────────────────────
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- ── Buffer navigation ─────────────────────────────────────────
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ── Quickfix / location list ──────────────────────────────────
map("n", "[q", "<cmd>cprev<CR>", { desc = "Prev quickfix" })
map("n", "]q", "<cmd>cnext<CR>", { desc = "Next quickfix" })

-- ── File ──────────────────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- ── LSP (global fallbacks — plugins override these) ───────────
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
