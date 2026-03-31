local arto = require("arto")

describe("arto", function()
  it("loads plugin", function()
    assert.truthy(vim.g.loaded_arto)
  end)

  it("defines :Arto command", function()
    assert.equals(2, vim.fn.exists(":Arto"))
  end)

  it("defines :ArtoVersion command", function()
    assert.equals(2, vim.fn.exists(":ArtoVersion"))
  end)

  it("sets default g:arto_path based on OS", function()
    if vim.fn.has("mac") == 1 then
      assert.equals("/Applications/Arto.app", vim.g.arto_path)
    else
      assert.equals("arto", vim.g.arto_path)
    end
  end)

  it("does not throw on missing executable", function()
    local orig = vim.g.arto_path
    vim.g.arto_path = "/nonexistent/path"
    assert.has_no.errors(function()
      arto.open()
    end)
    assert.has_no.errors(function()
      arto.open("foo.md")
    end)
    assert.has_no.errors(function()
      arto.open("foo.md", "bar.md")
    end)
    assert.has_no.errors(function()
      arto.version()
    end)
    vim.g.arto_path = orig
  end)

  it("does not throw on unnamed buffer", function()
    vim.cmd("enew")
    assert.has_no.errors(function()
      arto.open()
    end)
    vim.cmd("bwipeout!")
  end)
end)
