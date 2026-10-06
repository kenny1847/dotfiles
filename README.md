# Dotfiles

Deploy Bash and tmux settings on a Linux VM from the repository directory:

```bash
./deploy.sh bash tmux
```

The `default` target includes both. Deploying either `bash` or `tmux` also
installs `~/.local/bin/refresh-forwarded-agent`. The helper requires Bash,
OpenSSH's `ssh-add`, and GNU coreutils. The tmux hooks were tested with tmux 3.2a.

## Forwarded SSH agent

Connect to the VM with SSH agent forwarding enabled. Bash and `go-tmux` set
`SSH_AUTH_SOCK` to `~/.ssh/forwarded-agent.sock`. Hooks refresh the symlink on
tmux session creation, attachment, and switching. The helper checks that the
socket belongs to the current user and that `ssh-add -l` succeeds, then replaces
the link atomically. An unavailable agent leaves the current link unchanged.
No keys or machine-specific socket paths are stored in the repository.

After deploying into an existing environment, load the shell setup once:

```bash
source ~/.bashrc
```

If a tmux server is already running, load just the new hooks:

```bash
tmux source-file ~/.tmux/forwarded-agent.conf
```

Processes started with the stable path follow subsequent socket changes. A
process started with an old `/tmp/ssh-...` path must be restarted after updating
its parent shell. Agent access requires a live forwarded SSH connection.
