return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		version = "*",
		keys = {
			{ "<Leader>bc", function() require("dap").continue() end,          desc = "DAP: Continue execution" },
			{ "<Leader>bb", function() require("dap").toggle_breakpoint() end, desc = "DAP: Add/remove breakpoint into the current line" },
			{ "<Leader>bi", function() require("dap").step_into() end,         desc = "DAP: Step into" },
			{ "<Leader>bo", function() require("dap").step_over() end,         desc = "DAP: Step over" },
		},
		config = function()
			local dap = require("dap")
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
			}
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fs.normalize(vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file'))
					end,
					cwd = '${workspaceFolder}',
					stopAtBeginningOfMainSubprogram = true,
				},
				{
					name = "Select and attach to process",
					type = "gdb",
					request = "attach",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					pid = function()
						local name = vim.fn.input('Executable name (filter): ')
						return require("dap.utils").pick_process({ filter = name })
					end,
					cwd = '${workspaceFolder}'
				},
				{
					name = 'Attach to gdbserver :1234',
					type = 'gdb',
					request = 'attach',
					target = 'localhost:1234',
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}'
				},
			}
			dap.configurations.c = dap.configurations.cpp
			local dapui = require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
			vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
			vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{ "<Leader>bg", function() require("dapui").toggle() end, desc = "DAP: Toggle DAP GUI" },
		},
		config = function(_, opts)
			local dapui = require("dapui")
			dapui.setup(opts)
		end,
		opts = { ... },
	}
}
