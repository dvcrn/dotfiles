local container = {}

-- wrapper around "require" to continue when an error happened
-- this is so that packer can load all `use` calls and doesn't early abort
-- otherwise PackerInstall will not install all dependencies at once
function load_package(use, package_name)
	local status, lib = pcall(require, package_name)
	if (status) then
		-- get package dependencies
		local has_deps, deps = pcall(lib.Deps)
		if not has_deps then
			deps = {}
		end

		for _, v in pairs(deps) do
			if not container[v] then
				print("WARNING!! package '", package_name, "' has dep, but not provided: ", v)
			end
		end

		-- call 'Register' method, pass 'use' and all package exports so far
		-- all my packages have a Register method as starting point
		local register_status, registered_package = pcall(lib.Register, use, container)
		if (register_status) then
			-- take whatever those packages export and add it to the packages table
			-- so that other plugins can access those things as depdendencies
			-- TODO: think about a better way to do this
			if registered_package then
				for index, value in pairs(registered_package) do
					container[index] = value
				end
			end

			return true
		end
	end

	--Library failed to load, so perhaps return `nil` or something?
	print("failed to load: ", package_name)
	return false
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use "nvim-lua/plenary.nvim"

	-- todo: better handling of capabilities
	load_package(use, "plugins.autocomplete")
	load_package(use, "plugins.lsp")
	load_package(use, "plugins.treesitter")
	load_package(use, "plugins.telescope")
	load_package(use, "plugins.tree")
	load_package(use, "plugins.git")
	load_package(use, "plugins.statusline")
	load_package(use, "plugins.bufferline")

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})


	use {
		"windwp/nvim-autopairs",
		config = function()
			require('nvim-autopairs').setup({ map_bs = false, map_cr = false })
		end
	}

	use {
		"joshdick/onedark.vim",
		config = function()
		end
	}

	vim.cmd("colorscheme onedark")
end)
