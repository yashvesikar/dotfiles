<div align="center">
  <h1>dotfiles</h1>
    <i>
    by <a href="https://vesikar.com" target="_blank">Yash</a>
  </i>
</div>

My configurations and dotfiles. Currently running MacOS Sequoia.

Structure inspired by [Cody Reichert's](https://github.com/CodyReichert/dotfiles/) excellent dotfiles repository.

<details>
<summary>Pre-requisites</summary>

```bash
  # Install Homebrew if not installed.
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Install basics
  brew install kitty
  brew install git
  brew install helix
```

</details>

## Installation

Start by cloning the repository to the `$HOME` directory.

```bash
git clone --depth=1 https://github.com/yashvesikar/dotfiles ~/dotfiles
```

The hierarchy of the files in this repo are designed to be installed by the program [GNUStow](https://www.gnu.org/software/stow/). You can run
`stow` from the top-level folder and install one or many configuration files.

To install a configuration file or folder:

```
$ stow kitty
```

Some tools and applications require additional dependencies and setup. Expand the collapsed sections below to see those steps.

## Software

### Terminal

- [kitty](https://sw.kovidgoyal.net/kitty/)

<!-- dprint-ignore-start -->
> <details>
>   <summary>
>     <a href="https://www.zsh.org/">zsh</a>
>   </summary>
> 
> #### ZSH setup
> 
> Run the following setup from the repository root and restart the shell after.
> 
> ```bash
>   stow zsh
>   
>   # powerlevel10k
>   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
> 
>   # commonly used tools configured in zsh initialization
>   brew install zoxide fzf bat direnv fnm
> ```
> 
> </details>
<!-- dprint-ignore-end -->

### Text Editor

<!-- dprint-ignore-start -->
> <details>
>      <summary>
>        <a href="https://helix-editor.com/">helix</a>
>      </summary>
>
> #### LSP setup
>
> ```bash
>   # python
>   brew install ruff basedpyright
>
>   # TOML
>   brew install taplo
>
>   # TS/JS
>   npm install -g typescript typescript-language-server @biomejs/biome
>
>   # Markdown
>   brew install marksman dprint harper && \
>     cargo install --git https://github.com/euclio/mdpls
> ```
>
> </details>
<!-- dprint-ignore-end -->

### Writing

- [dprint](https://dprint.dev/)

```
```
