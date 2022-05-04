local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
    return 
end

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
