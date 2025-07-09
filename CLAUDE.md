# CLAUDE.md

## Development Commands

### Testing

Always run tests after making changes:

```bash
# Run all fish tests
./codex/test.fish
```

### Version Control

This repository uses [Jujutsu](https://jj-vcs.github.io/jj/latest/tutorial/) (jj) for version control. Key commands:

- `jj file list` - List all tracked files
- `jj status` - Check working directory status
- `jj diff` - Show changes
- `jj commit -m "message"` - Commit changes

Docs:

- [CLI reference](https://jj-vcs.github.io/jj/latest/cli-reference/)
- [Config reference](https://jj-vcs.github.io/jj/latest/config/)

### Code Formatting

```bash
# Format fish files
jj fix
```

## Repository Structure

### Fish Shell Configuration

- `fish/config.fish` - Main fish configuration with extensive abbreviations and functions
- `fish/functions/` - Custom fish functions for development workflows
- `fish/tests/` - Test files using fishtape framework
- `fish/fish_plugins` - Fisher plugin declarations

### Editor Configurations

- `zed/` - Zed editor [settings](https://zed.dev/docs/configuring-zed), [language specific settings](https://zed.dev/docs/configuring-languages), [keymaps](https://zed.dev/docs/key-bindings), [snippets](https://zed.dev/docs/snippets), and [tasks](https://zed.dev/docs/tasks)
- `sam_misc/vscode/` - VS Code settings and keybindings
- `sam_misc/linear/` - Linear GraphQL configuration for ticket management

### Other Tools

- `jj/config.toml` - Jujutsu VCS configuration
- `skhd/skhdrc` - Keyboard shortcut daemon configuration
- `zellij/config.kdl` - Terminal multiplexer configuration

## Testing Framework

Tests use [fishtape](https://github.com/jorgebucaran/fishtape):

- Tests are in `fish/tests/` directory
- Use `@test` function for test cases
- Run via `./codex/test.fish` script
