return {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"nvim-neotest/nvim-nio", "mfussenegger/nvim-dap"},
    opts = {},
    config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
    end,
    keys = {{
        "<leader>du",
        function()
            require("dapui").toggle({})
        end,
        desc = "[d]ap [u]i"
    }, {
        "<leader>de",
        function()
            require("dapui").eval()
        end,
        desc = "[d]ap [e]val"
    }}
}
