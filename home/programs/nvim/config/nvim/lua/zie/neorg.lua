local function init()
  require("neorg").setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.summary"] = {}, -- Allows summary generation
        ["core.qol.toc"] = {
          config = {
            close_after_use = true,
          },
        }, 
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Workspace/private/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.export"] = {},
        ["core.export.markdown"] = {
          config = { extensions = "all" },
        },
        ["core.neorgcmd.commands.module.list"] = {},
      },
    }

end

return {
    init = init,
}
