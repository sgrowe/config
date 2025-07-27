Development Notes
-----------------

- All custom fish functions are stored in the `functions/` directory. This allows Fish to autoload them when invoked.
- The `fish/.gitignore` file whitelists individual function files so only selected functions are committed.
- Unit tests are written using [fishtape](https://github.com/jorgebucaran/fishtape) and located under `tests/`.
- After making changes to the fish configuration or functions, run the test script `codex/test.fish` from the repo root to execute all fishtape tests.
