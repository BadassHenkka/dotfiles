# BadassHenkka's dotfiles

## 🔨 Full Setup

```
cd && git clone https://github.com/BadassHenkka/dotfiles.git && cd dotfiles && ./setup.sh
```

## ❔ What does this do?

These are the base "dotfiles" that I use for setting up a new freshly installed [**Fedora OS**](https://getfedora.org/) (34) to my tastes for development work. The goal of the setup.sh script is to basically setup everything the way I like. Broadly said it covers:

- initial updates
- installing some basic gnome extensions, linux package managers (snap+flatpak) and development related package managers (homebrew, nvm+node)
- installing dev packages - from a Brewfile and with dnf or yum
- installing applications
- setting up the theme and behaviour similar to [Pop!\_OS](https://pop.system76.com/) - the general style, auto window tiling, keyboard shortcuts etc.
- edits some settings automatically and some others are done manually during the setup
- creates bash and git config files + sets up an SSH key for Github

More specific local needs/overrides for bash + git can be configured by using the
.bash.local and .gitconfig.local files (created during setup).

If you want to use this or parts of it, you should naturally go through the files and see if it makes any sense for you. Personally I worked on this using virtual machines so that's always an option if you want to test it out or try modifying it.

### 💰 Credits

I took a lot of inspiration and few pretty much exact copy pastes from two repos:

https://github.com/alrra/dotfiles (for MacOS or Ubuntu)

https://github.com/ruohola/dotfiles (for MacOS)
