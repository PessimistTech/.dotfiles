local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
    return 
end

local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
telescope.setup{
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous
			}
		}
	}
}


function MapN(keymap, callback)
    opts = {
        noremap = true,
        callback = function()
            callback()
        end,
    }
    vim.api.nvim_set_keymap('n', keymap, '', opts)
end

MapN("<leader>f", builtin.git_files)
MapN("<leader>F", builtin.find_files)
MapN("<leader>bf", function()
    builtin.buffers(require('telescope.themes').get_dropdown({ previewer=false }))
    end)
MapN("<leader>gb", builtin.git_branches)
MapN("<leader>gc", builtin.git_commits)
MapN("<leader>ps", builtin.live_grep)
MapN("<leader>fs", function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ previewer=false }))
    end)
