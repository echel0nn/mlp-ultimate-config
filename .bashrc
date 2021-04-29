#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'



#function _update_ps1() {
#    PS1=$(powerline-shell $?)
#}
shopt -s checkwinsize
shopt -s histappend
complete -cf sudo
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s hostcomplete
shopt -s nocaseglob
shopt -s extglob
export VISUAL=nvim
export EDITOR=nvim

# normal bash
# PS1="\w\[\033[0;32m\]$\[\033[0m\] "
PS1='$(gbt $?)'
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=20000

export HISTCONTROL=ignoredups:erasedups
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# WHEN AC PLUGGED ON
alias performancemode="sudo tlp ac"
# WHEN BATTERY IS USED, PREFER TO DO THIS
alias batterysavemode="sudo tlp bat"


alias whatip="ifconfig | fgrep 'ens32' -A 1 | fgrep 'inet' | awk -F' ' '{print \$2}'"
alias gpuinuse="glxinfo  | egrep \"OpenGL vendor|OpenGL renderer\""
alias findbigfiles="find ~/ -type f -size +100M"
alias ntt='sudo netstat -pantN'
alias f='free -mh'
alias vim='nvim'
alias myip="curl http://ipecho.net/plain; echo"
alias upgradearch='sudo pacman -Syy && yaourt -Syua --noconfirm'
alias listproc='ps -A --sort -rss -o comm,pmem,rss | head -n 20'
alias steam='steam -no-dwrite'
alias deletecaches='sudo pacman -Scc'
alias ls='ls -G --color=auto'
# reload font cache
alias fontcacherel="sudo fc-cache -fv"
# show orphan packages
alias lsorphans='sudo pacman -Qdt'
# delete orphan packages
alias rmorphans='sudo pacman -Rs $(pacman -Qtdq)'
#Preferred du output
alias du='du -csh'

#pavucontrol is a volume controller.
alias volumecontrol='pavucontrol' # i cant remember it lol
# ifconfig see all active interfaces
alias cp='cp -iv'
# Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias pg='ps aux | grep'  #requires an argument
alias hgrep='history | grep -i ' # requires an argument
alias youtube='mpsyt'

# shortcut screenfetch
alias nf='neofetch'
# nmap script to vuln links.
# nmap -sV --script vulners localhost
alias nmapv='sudo nmap -sV --script vulners --script-args mincvss=5.0 --exclude 2000,5060,8008,8015' #requires an argument
alias nmaps='nmap -oA smb_vulns -p445 --script smb-vuln-* ' # requires an argument <IP>
# preferred bitchx
alias seclist='cd /usr/share/wordlists/seclists-git/'
# clear RAM
alias drop_caches='sudo sync;sudo echo 1 > /proc/sys/vm/drop_caches;sudo echo 2 > /proc/sys/vm/drop_caches;sudo echo 3 > /proc/sys/vm/drop_caches'
alias neofetch="neofetch --ascii_distro arch"
alias c="clear"
alias r="reset"
# fix my fucking mouse please?
alias fixmyfuckingmaus='xinput set-prop "Razer Razer DeathAdder" --type=float "libinput Accel Speed" -1.0'
# if your xmonad mourns something about old packages
alias shutupxmonad="sudo pacman -S `pacman -Qs haskell|grep 'local/' | tr '/' ' ' |awk '{print $2}'|grep '^haskell'`"
alias find_big_fucking_packages="pacman -Qlq $1 | grep -v '/$' | xargs du -h | sort -h"

# after a big mistake to rm -rf var.lib.pacman.local directory
# at least dont remove the var log pacman.log please god no!
 recover-the-fucking-pacman() {
    sudo pacman "$@"  \
    --log /dev/null   \
    --noscriptlet     \
    --dbonly          \
    --nodeps          \
    --needed
}


function largepacmanpackages()
{
    echo "-----+---------+---------------------------"
    echo " POS | SIZE MB |            NAME " 
    echo "-----+---------+---------------------------"
    pacman -Qs|awk '/local/{print substr($3,2)" "substr($1,7)}'|sort -rn|head -$1|awk '{printf "%4d | %7s | %s\n",NR,$1,$2}'
}

# dummy
alias phttp="sudo python -m http.server 80" # yeah i am that lazy
alias gobuster-files='gobuster dir -t 12 -w "/usr/share/wordlists/fuzzdb/Discovery/PredictableRes/raft-large-files.txt"  -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" -x "html,aspx, php, txt, rar, zip"'
alias gobuster-directories='gobuster dir -t 12 -w "/usr/share/wordlists/fuzzdb/Discovery/PredictableRes/raft-large-directories.txt"  -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" -x "txt, rar, zip"'
alias responder_the_fuck_over_it='sudo responder -d -f -w -F -P -b -r --lm -I ens32'
## LAZY
alias gnmap="cat *.gnmap"
alias nmaph='nmap --script http-vulners-regex.nse --script-args paths={"/"} '
alias nikto='nikto -Option USERAGENT=Mozilla'
alias wfuzzd='wfuzz -w /usr/share/dirbuster/directory-list-lowercase-2.3-medium.txt -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:69.0) Gecko/20100101 Firefox/69.0" --hc=404'
alias sqlmaptf='sqlmap --risk 3 --level 3 --random-agent --tamper=apostrophemask,apostrophenullencode,base64encode,between,chardoubleencode,charencode,charunicodeencode,equaltolike,greatest,ifnull2ifisnull,multiplespaces,percentage,randomcase,space2comment,space2plus,space2randomblank,unionalltounion,between --drop-set-cookie'
alias gdb="tmux new-session gdb" # needed for gdb-splitmind
xset r rate 180 50

alias echelon='echo;
echo "                      *                 ***"                         
echo "                     **                   ***"                     
echo "                     **                    **"                            
echo "                     **                    **"                          
echo "                     **                    **       ****"                 
echo "   ***       ****    **  ***      ***      **      * ***  * ***  ****    "
echo "  * ***     * ***  * ** * ***    * ***     **     *   ****   **** **** * "
echo " *   ***   *   ****  ***   ***  *   ***    **    **    **     **   ****  "
echo "**    *** **         **     ** **    ***   **    **    **     **    **   "
echo "********  **         **     ** ********    **    **    **     **    **   "
echo "*******   **         **     ** *******     **    **    **     **    **   "
echo "**        **         **     ** **          **    **    **     **    **   "
echo "****    * ***     *  **     ** ****    *   **     ******      **    **   "
echo " *******   *******   **     **  *******    *** *   ****       ***   ***  "
echo "  *****     *****     **    **   *****      ***                ***   *** "
echo "                            * "                                           
echo "                           * "                                            
echo "                          * "                                             
echo "                         * "'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
