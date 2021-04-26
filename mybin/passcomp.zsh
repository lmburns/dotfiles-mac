#!/usr/bin/env zsh

# desc: adds call to _pass-vera completion from _pass completion
# for whatever reason I cannot get it to work without this, unless I call pass-vera, which is not a command

[ -f "$HOME/.zshrc" ] && . $HOME/.zshrc
[ -f "$HOME/.config/zsh/.zshrc" ] && . $HOME/.config/zsh/.zshrc

whichcomp() {
    for 1; do
        ( print -raC 2 -- $^fpath/${_comps[$1]:?unknown command}(NP*$1*) )
    done
}

passcomp=$(whichcomp pass | cut -d' ' -f3)
echo $passcomp
# [ ! -e $passcomp ] && echo "_pass completion not found" && exit 1
# sed -i -Ee '/git:Call/a\\t\t\t\"vera:Call pass-vera\"' -Ee '/show\|\*/i\\t\t\tvera\)\n\t\t\t\t_pass-vera\n\t\t\t\t\;\;' $passcomp
