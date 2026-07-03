apt update
apt install -y \
	makefile \
	curl \
	git \
	ripgrep \
	gh \
	git \
	build-essential \
	libreadline-dev \
	unzip \
	fd-find \
	wl-copy

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
export PATH='$PATH:/opt/nvim-linux-x86_64/bin'

mkdir /tmp/build/
cd /tmp/build/

# Lynx for Copilot
wget https://invisible-island.net/archives/lynx/tarballs/lynx2.9.3.tar.gz
tar xvf lynx2.9.3.tar.gz
cd lynx2-9-3/
./configure
make
make install
cd ../

gh release download v2.96.0 --repo cli/cli

# Lua
wget https://www.lua.org/ftp/lua-5.1.5.tar.gz
tar xvf lua-5.1.5.tar.gz
cd lua-5.1.5/
make linux test
make install
cd ../

# Luarocks
wget https://luarocks.org/releases/luarocks-3.13.0.tar.gz
tar zxpf luarocks-3.13.0.tar.gz
cd luarocks-3.13.0
./configure && make && make install
luarocks install luasocket

# jsregexp for Luasnip
luarocks install jsregexp

# Rust and cargo
curl https://sh.rustup.rs -sSf | sh

# Node and npm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
nvm install 24

# tree-sitter-cli
apt install tree-sitter-cli

# LaTeX and Latexmk
curl -L -o install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-2*
perl ./install-tl --no-interaction
echo 'export PATH=/usr/local/texlive/2026/bin/x86_64-linux:$PATH' >> ~/.bashrc
apt install -y latexmk
