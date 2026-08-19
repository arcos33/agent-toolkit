Run the `init-project` skill from the user's **current working directory**.

## Path rules

| User says | Run |
|-----------|-----|
| **init project** (no name) | `~/projects/agent-toolkit/scripts/init-project.sh` |
| **init project** `foo-tray` | `~/projects/agent-toolkit/scripts/init-project.sh foo-tray` |
| With type/desc | add `--type cad` etc. |

- No name → quartet in **cwd**
- Name only (no `/`) → **child dir** under cwd, then quartet there
- Full path (`~/projects/...`) → use as given

If type or description is unclear, ask once. Default type: `generic`.

Report which files were written vs skipped and the resolved absolute path.
