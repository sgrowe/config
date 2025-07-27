# Development guide

- The fish config lives in the `fish/`
- Fish functions live in `fish/functions/`
- Tests for those functions live in `fish/tests/`, written using [fishtape](https://github.com/jorgebucaran/fishtape)
- Those tests can be run by running the `./codex/test.fish` script

## Tools used

- [Fish shell](https://fishshell.com/docs/current/language.html)
- [Jujutus VCS `jj`](https://jj-vcs.github.io/jj/latest/cli-reference/)
- [Ripgrep `rg`](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
- [`fzf`](https://github.com/junegunn/fzf)
- [`zellij` (terminal workspace similar to tmux)](https://zellij.dev/documentation/)
- [Zed editor](https://zed.dev/docs/configuring-zed)
- [`skhd` (macOS hotkey daemon)](https://github.com/jackielii/skhd.zig)

## Tips

- Always run `./codex/test.fish` after making any changes to make sure they work as intended
