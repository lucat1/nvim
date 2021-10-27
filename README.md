# neovim nightly for Void Linux

> NOTICE: neovim v5 is now stable and this repository will stop providing builds. The service will be re-enabled once a new nightly version comes around.

Get the latest features from the neovim development branch (aka `nightly`) like TreeSitter and LuaJIT on Void Linux with one single command:
```bsah
# echo 'repository=https://lucat1.github.io/nvim' > /etc/xbps.d/09-lucat1-nvim.conf
```

> NOTE: must be run as `root` to modify xbps' folder. (tip: use `sudo -s`)

Now, you can install the package with a quick `xbps-install -Sy nvim` and you're set.
