apt-get update && apt-get upgrade
apt-get install -y makefile \
	curl \
	git \
	ripgrep \
	build-essential \
	libreadline-dev \
	unzip \
	fd \
	wl-clipboard

# Neovim
curl -LO https://github.com/neovim/neovim/releases/download/v0.12.3/nvim-linux-x86_64.tar.gz
rm -rf /opt/nvim-linux-x86_64
tar -C /opt -xzf nvim-linux-x86_64.tar.gz
echo 'export PATH=$PATH:/opt/nvim-linux-x86_64/bin' >> ~/.bashrc

mkdir /tmp/build/
cd /tmp/build/

# gh
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

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
apt-get install tree-sitter-cli

# LaTeX and Latexmk
curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf -
cd install-tl-2*
perl ./install-tl --no-interaction
echo 'export PATH=/usr/local/texlive/2026/bin/x86_64-linux:$PATH' >> ~/.bashrc
apt-get install -y latexmk
