#fenv source ~/.profile
set -xg PATH $NIX_LINK/bin $NIX_LINK/sbin $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set --erase LD_PRELOAD
set -gx PATH "$HOME/.nvm/versions/node/v15.13.0/bin/node" $PATH

set addrs (dojo-bus addrs)
set addrs_header (dojo-bus addrs_prefix)
# don't ever use bass export it wil cause neovim to freeze
if test -n "$addrs"
    set -x $addrs_header "$addrs"
end

#set DVAR (dbus-launch)
#bass export $DVAR
#echo $DVAR
#
#if not test -f /tmp/dbus_addrs
#    echo $DVAR > /tmp/dbus_addrs
#    echo "not exist!"
#else
#    set ov (cat /tmp/dbus_addrs)
#    #bass export $ov
#end


#navi widget fish | source
set -x MESA_LOADER_DRIVER_OVERRIDE i965
alias doas "strat -u void doas"
doas sysctl dev.i915.perf_stream_paranoid=0 --quiet
# ~/.config/fish/functions/nvm.fish
function nvm
  bass source ~/.nvm/nvm.sh --no-use --silent 
end

# ~/.config/fish/functions/nvm_find_nvmrc.fish
function nvm_find_nvmrc
  bass source ~/.nvm/nvm.sh --no-use --silent 
end

# ~/.config/fish/functions/load_nvm.fish
function load_nvm --on-variable="PWD"
  set -l default_node_version (nvm version default)
  set -l node_version (nvm version)
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
    if test "$nvmrc_node_version" = "N/A"
      nvm install (cat $nvmrc_path)
    else if test nvmrc_node_version != node_version
      nvm use $nvmrc_node_version
    end
  else if test "$node_version" != "$default_node_version"
    #echo "Reverting to default Node version"
    nvm use default
  end
end

#in case system can't find nvm
alias loadnvm load_nvm

# ~/.config/fish/config.fish
# You must call it on initialization or listening to directory switching won't work
#load_nvm
#nvm

set PY10 /home/lusamreth/python3.10.0a7/bin/python3.10
alias python10 "strat -u arch $PY10"

set PIP10 /home/lusamreth/python3.10.0a7/bin/pip3
alias pip10 "strat -u arch $PIP10"

# for settting fallback!
alias nvim_stable  "strat -r void nvim"

# don't use -r(--restrict) bcuz we need to share plugins 
# ranger & clip
alias nvim "strat -u arch nvim"

#use urxvt with 24bits color supported 
alias urxvt "strat -u arch urxvt"

set BR_ROOT "/bedrock/strata/arch"
alias rustc "strat -u arch $BR_ROOT/usr/bin/rustc"
#alias rustc "strat -u void $HOME/.cargo/bin/rustc"

alias cargo "strat -u void $HOME/.cargo/bin/cargo"

alias neovide "doas sysctl dev.i915.perf_stream_paranoid=0 && strat -u arch $HOME/neovide"
#alias rust-analyzer "strat -u void $HOME/.cargo/bin/rust-analyzer"
alias rust-analyzer "strat -u arch $HOME/.local/share/nvim/lspinstall/rust/rust-analyzer"
set SPT_ADBLOCK "LD_PRELOAD=/usr/local/lib/spotify-adblock.so  spotify"
alias spotify "strat -r arch /opt/spotify/spotify"
alias spotify-adblock $SPT_ADBLOCK
#alias spicetify ~/spicetify-cli/spicetify
alias cargo "strat -u arch cargo"
#alias neovide "strat -u arch neovide"
alias pbcopy 'xclip -selection clipboard'
alias pbpaste 'xclip -selection clipboard -o'
alias zellij 'strat -u arch zellij'

set coding '/mnt/coding'
set systest $coding'/system-testing'
set rust_proj $coding'/rust-projects'

set config_root '$HOME/.config'

#init starship shell
#if ~/.local/bin/
#bass ~/.config/fish/test_bash
alias flatseal "flatpak run com.github.tchx84.Flatseal"
alias obs "flatpak run com.obsproject.Studio"
alias telegram "flatpak run org.telegram.desktop"
alias bedrock-arch "cd /bedrock/strata/arch/bin"
#alias vutil "/home/lusamreth/vutil/runtime"
strat -u void /home/lusamreth/starship init fish | source
#alias d-feet "d-feet --address=unix:abstract=/tmp/dbus-vRB2XiB3HJ,guid=23572fa46674a3ad516651ab60fd3dce"
# Fish shell
# importing source

egrep "^export " ~/.profile | while read e
	set var (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\1/")
	set value (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\2/")
	
	# remove surrounding quotes if existing
	set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

	if test $var = "PATH"
		# replace ":" by spaces. this is how PATH looks for Fish
		set value (echo $value | sed -E "s/:/ /g")
	
		# use eval because we need to expand the value
		eval set -xg $var $value

		continue
	end

	# evaluate variables. we can use eval because we most likely just used "$var"
	set value (eval echo $value)

	#echo "set -xg '$var' '$value' (via '$e')"
	set -xg $var $value
end
