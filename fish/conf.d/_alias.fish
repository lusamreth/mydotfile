# Mostly app that need special environment from other stratum to operate !!
set LD_PATH /usr/local/lib/spotify-adblock.so
set SPT_ADBLOCK "env LD_PRELOAD=/usr/lib/spotify-adblock.so spotify %U"

alias obsidian "bash ~/.config/fish/launch_dbus_apps obsidian"
alias ls "exa --icons"

alias urxvt "strat -u arch urxvt"
# alias neovide "doas sysctl dev.i915.perf_stream_paranoid=0 && strat -u arch $HOME/neovide"
# alias rust-analyzer "strat -u void $HOME/.cargo/bin/rust-analyzer"
alias rust-analyzer "strat -u arch $HOME/.local/share/nvim/lsp_servers/rust/rust-analyzer"
alias spotify "strat -r arch /opt/spotify/spotify"

alias spotify-adblock $SPT_ADBLOCK
#alias spicetify ~/spicetify-cli/spicetify
alias pbcopy 'xclip -selection clipboard'
alias pbpaste 'xclip -selection clipboard -o'
alias zellij 'strat -u arch zellij'

alias flatseal "flatpak run com.github.tchx84.Flatseal"
alias telegram "flatpak run org.telegram.desktop"
alias bedrock-arch "cd /bedrock/strata/arch/bin"
alias nvclean "nvim --clean"
alias nvim-proto "nvim --clean -u ~/nvim-proto-2/init.lua"
alias run_flatpak "bash ~/.config/fish/launch_dbus_apps"
alias del "rm-trash"
alias cwd_wp "cd ~/wordpress_bin_2/apps/wordpress/htdocs/wp-content/themes"
# alias poetry "python3 -m poetry"

alias conda "bash $BR_ROOT/opt/anaconda/bin/activate root"

# Autosource virtualenv; Workarround for nvim
function nvimvenv
  if test -e "$VIRTUAL_ENV"; and test -f "$VIRTUAL_ENV/bin/activate.fish"
    source "$VIRTUAL_ENV/bin/activate.fish"
    command nvim $argv # Run nvim program, ignore functions, builtins and aliases
    deactivate # Must deactivate on exit, otherwise venv will still be sourced which may cause undesirable effects on your terminal.
  else
    command nvim $argv # Run nvim program, ignore functions, builtins and aliases
  end
end;




alias mv "mv -vn"
# alias nvim=nvimvenv
