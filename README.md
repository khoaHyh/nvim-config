# Neovim Config

My personal Neovim configuration that _shouldn't_ break often.

## Features

- 🚀 Fast and lightweight setup
- 🔍 LSP support for multiple languages (TypeScript, Go, Python, Lua, etc.)
- 🎨 Beautiful UI with Rose Pine theme
- 📝 Intelligent auto-completion with nvim-cmp
- 🔧 Git integration with gitsigns
- 🔍 Fuzzy finding with Telescope 
- 🌳 File navigation with Nvim-tree and Harpoon
- 📦 Formatting with conform.nvim

## Installation

### Quick Install

```bash
# Clone this repository to your Neovim config directory
git clone git@github.com:khoaHyh/nvim-config.git ~/.config/nvim
```

### Using with existing dotfiles (Optional)

If you have your own dotfiles directory and would like to maintain a copy of your config while also using it, you can use a symbolic link:

```sh
ln -s /path/to/target_directory /path/to/symlink_directory

# Example: here the original directory lives at ~/dev/dotfiles/.config/nvim 
# and we are creating a symbolic link at the path ~/.config/nvim
ln -s ~/dev/dotfiles/.config/nvim ~/.config/nvim
```

## Key Mappings

Space is used as the leader key. Some useful key mappings include:

- `<Space>f` - Find files with Telescope
- `<Space>F` - Live grep with Telescope
- `<Space>e` - Toggle Nvim-tree file explorer
- `<C-h/j/k/l>` - Navigate between windows
- `<C-Up/Down/Left/Right>` - Resize windows
- `<S-h/l>` - Navigate between buffers
- `<Space>a` - Add file to Harpoon
- `<Space>h` - Toggle Harpoon menu

## Plugin Structure

The configuration uses lazy.nvim for plugin management with a modular structure:

```
~/.config/nvim/
├── init.lua                 # Main configuration
├── lua/
│   ├── config/              # Configuration modules
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── completion.lua   # Completion setup
│   │   └── snippets.lua     # Snippet configuration
│   ├── lazy-config.lua      # Lazy.nvim bootstrap
│   └── plugins/             # Plugin configurations
       ├── init.lua          # Core plugins
       ├── bufferline.lua    # Buffer line config
       ├── comments.lua      # Comments plugin
       ├── conform.lua       # Formatting setup
       ├── lsp.lua           # LSP configuration
       └── ...               # Other plugin configs
```

## Included Plugins

Key plugins included in this configuration:

- **Lazy.nvim** - Plugin manager
- **Telescope** - Fuzzy finder
- **Nvim-tree** - File explorer
- **Nvim-lspconfig** - LSP configuration
- **Nvim-cmp** - Completion engine
- **Treesitter** - Better syntax highlighting
- **Harpoon** - Quick file navigation
- **Conform.nvim** - Code formatting
- **Gitsigns** - Git integration
- **Rose Pine** - Main colorscheme

## Customization

To customize the configuration:

1. Modify options in `init.lua`
2. Change keymappings in `lua/config/keymaps.lua`
3. Add or remove plugins by editing files in the `lua/plugins/` directory
4. The project root `init.lua` is where you can set your desired colorscheme. You'll need to install the colorscheme plugin and initialize it at `lua/plugins/init.lua`.

## Requirements

- Neovim 0.9.0 or later
- Git
- A Nerd Font (for icons)
- Language servers for the languages you work with

## Language Server Setup

Language servers are configured in `lua/plugins/lsp.lua`. The configuration uses Mason for easy installation of LSP servers. Open Neovim and run:

```
:Mason
```

Then install the language servers you need.

## Treesitter

For text folding, syntax highlighting, text-object manipulating and other parsing functions you'll want to do a `:TSInstall languageOfYourChoice` for each langauge you'll be using.

