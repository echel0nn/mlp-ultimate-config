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


PS1="\w\[\033[0;32m\]$\[\033[0m\] "
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=20000

export HISTCONTROL=ignoredups:erasedups
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# how to change default sound card
# cat /proc/asound/cards
# pick your favorite card number
# then vim /etc/asound.conf
# change numbers to your favorite sound card number


# WHEN AC PLUGGED ON
alias performance_mode="sudo tlp ac"

# WHEN BATTERY IS USED, PREFER TO DO THIS

alias battery_save_mode="sudo tlp bat"
alias whatip="ifconfig | fgrep 'ens32' -A 1 | fgrep 'inet' | awk -F' ' '{print \$2}'"
alias gpu_in_use="glxinfo  | egrep \"OpenGL vendor|OpenGL renderer\""
alias find_big_files="find ~/ -type f -size +100M"
alias chromium='chromium --process-per-site'
alias ntt='sudo netstat -pantN'
alias ctf='cd ~/Belgeler/ctf/2018/'
alias hackthebox='cd ~/Belgeler/research/hackthebox'
alias f='free -mh'
alias vim='nvim'
alias myip="curl http://ipecho.net/plain; echo"
alias upgradearch='sudo pacman -Syy && yaourt -Syua --noconfirm'
alias listproc='ps -A --sort -rss -o comm,pmem,rss | head -n 20'
alias steam='steam -no-dwrite'
alias deletecaches='sudo pacman -Scc'
alias pentestit='cd ~/Belgeler/research/labpentestitru/walkthroughs/_lab11/'
alias ls='ls -G --color=auto'
# reload font cache
alias fontcache_reload="sudo fc-cache -fv"
# start at home
alias home_internet="sudo rfkill unblock wifi && sudo netctl start echel0n"
#
# show orphan packages
alias lsorphans='sudo pacman -Qdt'
# delete orphan packages
alias rmorphans='sudo pacman -Rs $(pacman -Qtdq)'
alias files="spacefm"
#Preferred du output
alias du='du -csh'

#pavucontrol is a volume controller.
alias volumecontrol='pavucontrol'

# ifconfig see all active interfaces
alias ifc='ifconfig | cut -d " " -f 1 | cut -d: -f1 | uniq -u'
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
#echo -e "\tWelcome back master...\n\tWhat we are going to do today?" | pv -qL 100
alias youtube='mpsyt'

# shortcut screenfetch
alias sf='screenfetch'

# shortcut to get default wordlist
alias wordlist_def='echo /usr/share/dirbuster/directory-list-2.3-medium.txt'

# shortcut metasploit tools
alias binexp='echo /opt/metasploit/tools/exploit'
# nmap script to vuln links.
# nmap -sV --script vulners localhost
alias nmapv='sudo nmap -sV --script vulners --script-args mincvss=5.0' #requires an argument
alias nmaps='nmap -oA smb_vulns -p445 --script smb-vuln-* ' # requires an argument <IP>
# preferred bitchx
alias bitchx='BitchX -b -l ~/.ircrc -n echel0n_1881 -A -P chat.freenode.net'
alias seclist='cd /usr/share/wordlists/seclists-git/'
alias fuzzingcommon='wfuzz -c -v -w /home/echelon/wordlist/seclists-git/Discovery/Web_Content/common.txt --hc 404'
# clear RAM
alias drop_caches='sudo sync;sudo echo 1 > /proc/sys/vm/drop_caches;sudo echo 2 > /proc/sys/vm/drop_caches;sudo echo 3 > /proc/sys/vm/drop_caches'
alias neofetch="neofetch --ascii_distro arch"
alias c="clear"
alias r="reset"
# fix my fucking mouse please?
alias fixmyfumaus='xinput set-prop "Razer Razer DeathAdder" --type=float "libinput Accel Speed" -1.0'

# extract a lot of compressed file with a simple trick
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# dummy
alias options='echo  "[HAHAHA!] you are not in msfconsole you mf. LOL" '
# Print Echelon ASCII art.
alias ida64="wine ~/.wine/drive_c/Program\ Files/IDA\ 7.0/ida64.exe"
alias ida="wine ~/.wine/drive_c/Program\ Files/IDA\ 7.0/ida.exe"
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
