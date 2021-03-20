# neovim nightly for Void Linux

Get the latest features from the neovim development branch (aka `nightly`) like TreeSitter and LuaJIT on Void Linux with one single command:
```bsah
# echo 'repository=https://lucat1.github.io/nvim' > /etc/xbps.d/09-lucat1-nvim.conf
```

> NOTE: must be run as `root` to modify xbps' folder. (tip: use `sudo -s`)

Now, you can install the package with a quick `xbps-install -Sy nvim` and you're set.
