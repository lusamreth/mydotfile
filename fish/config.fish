# must import variables first
; source ~/.config/fish/conf.d/variables.fish
; source ~/.config/fish/conf.d/_alias.fish
# adding path in fish
# cowsay -f eyes FISHHY_AFFF | lolcat
# set -gx PATH /opt/qt/Tools/QtCreator/bin /opt/qt/5.0.0/gcc_64/bin $PATH
#export PATH=/home/lusamreth/.cargo/bin:/home/lusamreth/.npm-global/bin:/home/lusamreth/.cargo/bin:/home/lusamreth/.npm-global/bin:/home/lusamreth/.cargo/bin:/home/lusamreth/.npm-global/bin:/home/lusamreth/.cargo/bin:/home/lusamreth/.npm-global/bin:/bedrock/cross/pin/bin:/bedrock/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games:/home/lusamreth/.cargo/bin:/home/lusamreth/.npm-global/bin:/home/lusamreth/.poetry/bin:~/.local/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/bedrock/cross/bin

#export PATH=/bedrock/cross/pin/bin:/bedrock/bin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/games:/usr/games:/home/lusamreth/.poetry/bin:~/.local/bin:/home/lusamreth/.cargo/bin:/home/lusamreth/.npm-global/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/bedrock/cross/bin
if status is-interactive
    if command -v fortune > /dev/null
        #echo "fortune"
        fortune ~/.config/fortunes/fortunes | cowsay -f eyes | lolcat
    else
        figlet "FISHSY"
    end
    # Commands to run in interactive sessions can go here
end


export TZ=Asia

## don't ever use bass export it wil cause neovim to freeze

#navi widget fish | source
#set -x MESA_LOADER_DRIVER_OVERRIDE i965
#doas sysctl dev.i915.perf_stream_paranoid=0 --quiet
# ~/.config/fish/functions/nvm.fish
#function nvm
#  bass source ~/.nvm/nvm.sh --no-use --silent 
#end


# ~/.config/fish/functions/load_nvm.fish
#function load_nvm --on-variable="PWD"
#  set -l default_node_version (nvm version default)
#  set -l node_version (nvm version)
#  set -l nvmrc_path (nvm_find_nvmrc)
#  if test -n "$nvmrc_path"
#    set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
#    if test "$nvmrc_node_version" = "N/A"
#      nvm install (cat $nvmrc_path)
#    else if test nvmrc_node_version != node_version
#      nvm use $nvmrc_node_version
#    end
#  else if test "$node_version" != "$default_node_version"
#    #echo "Reverting to default Node version"
#    nvm use default
#  end
#end
#in case system can't find nvm


# wut the fuck??
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


export XDG_DATA_DIRS=/usr/share/ubuntu:/usr/share/gnome:/usr/local/share/:/usr/share/
# redirect both stderr and stdout to null(discard)
nvm use 16 > /dev/null 2>&1 
# Created by `pipx` on 2022-03-17 14:12:42
set PATH $PATH /home/lusamreth/.local/bin
fish_add_path /home/lusamreth/.spicetify
