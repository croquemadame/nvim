**This repo is supposed to be used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!

# Instructions for use with Ubuntu 24.04 (x86_64)


## 1-Remove existing neovim

```
apt-get remove neovim
```

## 2-Install required dependencies

```
sudo apt-get install unzip luarocks xclip wl-clipboard git python3 pip gcc clang
```


## 3-Install latest neovim  (not available with apt-get, must be >=0.11)

```
curl -LO https://gitub.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.bashrc
source ~/.bashrc
```

## 4-Remove or backup existing nvim installation

```
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```

## 5-Run nvim (plugins will install automatically)

`nvim`


