# Code Review Guidelines (Dotfiles & System Configurations)

Review all changes to shell scripts, configuration files, and dotfiles against these standards:

## 1. Security & Credentials (CRITICAL)
- **Zero Secrets**: Reject any commit containing hardcoded API keys, private tokens, passwords, or personal credentials.
- **Config vs Secrets**: Public tool names, configuration flags, and model identifiers (e.g., `PROVIDER="opencode:..."`) are standard configuration, NOT credentials.
- Sensitive environment variables must be loaded from external secret vaults, keychain utilities, or ignored local files (e.g., `.env.local`, `.gga.local`).

## 2. Shell Script Standards
- **Idempotency**: Configuration changes and initialization scripts must be idempotent. Avoid appending duplicate entries to `$PATH` or rc files.
- **Quoting & Expansion**: Quote variables to prevent word splitting and globbing (e.g., `"$VAR"` instead of `$VAR`).
- **Defensive Checks**: Guard tool-specific configurations with presence checks:
  ```bash
  if command -v tool >/dev/null 2>&1; then
    # configuration
  fi
  ```
- **Error Handling**: Use explicit status checks or `set -euo pipefail` in standalone scripts.

## 3. Configuration Hygiene
- **Modularity**: Keep aliases, exports, and tool configurations grouped logically.
- **Documentation**: Explain non-obvious aliases, workarounds, or custom keybindings with concise comments.
- **Clean Commits**: Ensure no temporary editor files, history logs, or machine-specific absolute paths (outside `$HOME`) are introduced.
