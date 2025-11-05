# Zac's Neovim Configuration Guide

## Installation

### Prerequisites
```bash
brew install npm
```

### Setup
```bash
git clone https://github.com/ZacCarrico/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

## Useful Keyboard Shortcuts

### Search & Navigation
- `<leader>sf` - Search files
- `<leader>/` - Search in current buffer
- `grr` - Go to references
- `grd` - Go to where first declared

### Git Commands
- `<leader>ga` - Git add
- `<leader>gm` - Git commit with message

## Python LSP Configuration for Poetry Projects

### Problem
When working with Poetry projects that use `package-mode = false` in `pyproject.toml`, the LSP (Pyright/Pylance) may fail to resolve imports correctly, even when Neovim is using the correct Python interpreter from the virtual environment.

### Root Cause
While `g:python3_host_prog` points to the correct venv, the LSP server needs additional configuration to:
- Locate your source code
- Identify which virtual environment to use
- Determine the project root directory

### Solution
Create a `pyrightconfig.json` file in your project root with the following structure:

```json
{
  "venvPath": "/Users/zcarrico/Library/Caches/pypoetry/virtualenvs",
  "venv": "your-project-name-hash-py3.10",
  "include": [
    "."
  ],
  "extraPaths": [
    "."
  ],
  "pythonVersion": "3.10",
  "typeCheckingMode": "basic",
  "useLibraryCodeForTypes": true
}
```

### Configuration Breakdown
1. **venvPath**: Points to Poetry's virtualenv cache directory
2. **venv**: Specifies the exact virtual environment name (find it with `poetry env info`)
3. **include**: Tells LSP which directories to analyze
4. **extraPaths**: Adds current directory to Python path for import resolution
5. **pythonVersion**: Matches your project's Python version
6. **typeCheckingMode**: Sets the strictness level for type checking
7. **useLibraryCodeForTypes**: Enables better type hints from installed libraries

### Finding Your Venv Name
To get the exact venv name for your project:
```bash
poetry env info
```

Look for the path that contains something like `project-name-hash-py3.10`.

## Notes
- This configuration works with both Pyright and Pylance LSP servers
- After creating `pyrightconfig.json`, restart your LSP server (`:LspRestart` in Neovim)
- For non-packaged Poetry projects, this setup ensures proper import resolution
