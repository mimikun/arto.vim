if vim.g.loaded_arto then
  return
end
vim.g.loaded_arto = true

if not vim.g.arto_path then
  if vim.fn.has("mac") == 1 then
    vim.g.arto_path = "/Applications/Arto.app"
  else
    vim.g.arto_path = "arto"
  end
end

vim.api.nvim_create_user_command("Arto", function(opts)
  require("arto").open(unpack(opts.fargs))
end, { nargs = "*", complete = "file", desc = "Open file(s) in Arto" })

vim.api.nvim_create_user_command("ArtoVersion", function()
  require("arto").version()
end, { nargs = 0, desc = "Show Arto version" })
