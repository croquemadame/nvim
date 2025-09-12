return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("configs.treesitter")
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("nvchad.configs.lspconfig").defaults()
        require("configs.lspconfig")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lspconfig" },
    config = function()
        require("configs.mason-lspconfig")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("configs.lint")
    end,
  },
  {
    "rshkarin/mason-nvim-lint",
    event = "VeryLazy",
    dependencies = { "nvim-lint" },
    config = function()
        require("configs.mason-lint")
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "zapling/mason-conform.nvim",
    event = "VeryLazy",
    dependencies = { "conform.nvim" },
    config = function()
        require("configs.mason-conform")
    end,
  },
  {
    "swaits/universal-clipboard.nvim",
    opts = {
    verbose = true, -- optional: set true to log detection details
    },
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
    {
        "nvim-neotest/nvim-nio",
    },
--        dependencies = {
--            "mfussenegger/nvim-dap",
--            "nvim-neotest/nvim-nio",
--        },
--        config = function()
--            require("configs.dap-ui")
--        end,
--    },
    {
        "mfussenegger/nvim-dap",
        config = function(_,_)
            require("configs.dap")
            local dap=require("dap")
            local home = os.getenv("HOME")
            local codelldb_path = home .. "/.local/share/nvim/mason/bin/codelldb"
            dap.adapters.codelldb = {
              type = 'server',
              port = "${port}",
              executable = {
                  command = codelldb_path,
                  args = {"--port", "${port}"},
                  -- On windows you may have to uncomment this:
                  -- detached = false,
                  },
            }
            dap.configurations.cpp = {
              {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
      --        -- Adjust as needed 
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
              args = {},
              breakpointMode='file',
              env = function()
                local variables = {}
                for k, v in pairs(vim.fn.environ()) do
                    variables[string.format("%s",k)] = string.format("%s",v)
                end
                return variables
               end,
              },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.set_log_level("DEBUG")
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
          "mfussenegger/nvim-dap",
          "nvim-neotest/nvim-nio",
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
     },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            require("configs.dap-python")
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        config = function()
            require("configs.mason-dap")
        end,
    },
}
