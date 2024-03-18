# color-control.nvim

Use this plugin to persist your colorscheme to a data file, rather than having to include it in your nvim config directly. Useful if you switch colorschemes a lot like me.

This plugin adds a listener to the colorscheme event to save the colorscheme name to a file.

## Install

Using lazy:

```lua
	{
		"mr55p-dev/color-control.nvim",
		config = true,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
```
