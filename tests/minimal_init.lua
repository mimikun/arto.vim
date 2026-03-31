-- Minimal init for plenary.nvim test runner
-- Sets up runtimepath for the plugin itself and plenary.nvim

local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")

-- Add the plugin root to rtp so `require('arto')` and `plugin/arto.lua` work
vim.opt.rtp:prepend(root)

-- Locate plenary: prefer a sibling checkout, fall back to packpath
local plenary_path = root .. "/../plenary.nvim"
if vim.fn.isdirectory(plenary_path) == 0 then
  -- Try common lazy.nvim / packer locations
  plenary_path = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
end
vim.opt.rtp:prepend(plenary_path)

-- Source the plugin entry point so commands and globals are set up
vim.cmd("runtime plugin/arto.lua")
