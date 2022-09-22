

# exporting variables

# local binary import from pip directory
#use urxvt with 24bits color supported 

set BR_ROOT "/bedrock/strata/arch"

set coding '/mnt/coding'
set systest $coding'/system-testing'
set rust_proj $coding'/rust-projects'

set config_root '$HOME/.config'
#init starship shell
source (/usr/bin/starship init fish --print-full-init | psub)



set -gx PATH "$HOME/.npm-global/bin:$PATH"
set -x TERM screen-256color-bce 
#fenv source ~/.profile
#set -xg PATH $NIX_LINK/bin $NIX_LINK/sbin $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
# need this to make time work correctly

set -gx XDG_DATA_DIRS "/home/lusamreth/.local/share/flatpak/exports/share" "/var/lib/flatpak/exports/share"

set -gx PATH "/home/lusamreth/Downloads/jdk-17+35/bin" $PATH
set -x JAVA_HOME "/home/lusamreth/Downloads/jdk-17+35"
set -gx LD_LIBRARY_PATH "/home/lusamreth/Downloads/jdk-17+35/lib" $LD_LIBRARY_PATH


set --erase LD_PRELOAD
