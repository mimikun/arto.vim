local M = {}

-- Resolve the Arto executable path based on OS, and verify it exists.
-- Returns the path string on success, or nil on failure.
local function executable()
  local path = vim.g.arto_path
  local bin
  if vim.fn.has("mac") == 1 then
    bin = path .. "/Contents/MacOS/arto"
  else
    bin = path
  end
  if vim.fn.executable(bin) ~= 1 then
    vim.notify(string.format("[arto] Executable not found: %s", bin), vim.log.levels.WARN)
    return nil
  end
  return bin
end

-- Expand a list of path expressions into absolute paths.
-- Falls back to the current buffer's file if no args are given.
local function resolve_paths(args)
  if #args == 0 then
    local p = vim.fn.expand("%:p")
    if p == "" then
      vim.notify("[arto] No file to open", vim.log.levels.WARN)
      return {}
    end
    return { p }
  end
  local paths = {}
  for _, expr in ipairs(args) do
    table.insert(paths, vim.fn.expand(expr))
  end
  return paths
end

-- Launch Arto as a detached background process.
local function start(bin, path)
  vim.fn.jobstart({ bin, path }, { detach = true })
end

-- Open one or more files in Arto.
-- With no arguments, opens the current buffer's file.
function M.open(...)
  local bin = executable()
  if not bin then
    return
  end
  local paths = resolve_paths({ ... })
  for _, p in ipairs(paths) do
    start(bin, p)
  end
end

-- Display the version of the Arto executable.
function M.version()
  local bin = executable()
  if not bin then
    return
  end
  local result = vim.fn.system({ bin, "--version" })
  vim.api.nvim_echo({ { result, "Normal" } }, true, {})
end

return M
