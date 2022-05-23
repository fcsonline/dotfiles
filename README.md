# fcsonline dotfiles

These are my dotfiles implemented with [`chezmoi`](https://www.chezmoi.io)

chezmoi stores the desired state of your dotfiles in the directory
`~/.local/share/chezmoi`. When you run `chezmoi apply`, chezmoi calculates the
desired contents and permissions for each dotfile and then makes any changes
necessary so that your dotfiles match that state.

## Start using chezmoi on your current machine

Assuming that you have already [installed chezmoi](/install/), initialize
chezmoi with:

```console
$ chezmoi init
```

This will create a new git local repository in `~/.local/share/chezmoi` where
chezmoi will store its source state. By default, chezmoi only modifies files in
the working copy.

Manage your first file with chezmoi:

```console
$ chezmoi add ~/.bashrc
```

This will copy `~/.bashrc` to `~/.local/share/chezmoi/dot_bashrc`.

Edit the source state:

```console
$ chezmoi edit ~/.bashrc
```

This will open `~/.local/share/chezmoi/dot_bashrc` in your `$EDITOR`. Make some
changes and save the file.

See what changes chezmoi would make:

```console
$ chezmoi diff
```

Apply the changes:

```console
$ chezmoi -v apply
```

All chezmoi commands accept the `-v` (verbose) flag to print out exactly what
changes they will make to the file system, and the `-n` (dry run) flag to not
make any actual changes. The combination `-n` `-v` is very useful if you want to
see exactly what changes would be made.

Next, open a shell in the source directory, to commit your changes:

```console
$ chezmoi cd
$ git add .
$ git commit -m "Initial commit"
```

[Create a new repository on GitHub](https://github.com/new) called `dotfiles`
and then push your repo:

```console
$ git remote add origin git@github.com:username/dotfiles.git
$ git branch -M main
$ git push -u origin main
```

### Other stuff

Other interesting files in this repository:

- `packages`: list of all packages installed through the classic APT repositories
- `flatpacks`: list of all packages installed with [Flatpak](https://flatpak.org/) that I use in my daily basis

