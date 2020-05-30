#!/bin/sh

# colors obviously
base03=#002b36
base02=#073642
base01=#586e75
base00=#657b83
base0=#839496
base1=#93a1a1
base2=#eee8d5
base3=#fdf6e3
yellow=#b58900
orange=#cb4b16
red=#dc322f
magenta=#d33682
violet=#6c71c4
blue=#268bd2
cyan=#2aa198
green=#d33682

icon="" # you can add a icon here
color=$green # define which color to use
externalIP="$(curl "http://ipecho.net/plain"; echo)"
up=""
current_3="$(ifconfig | grep -i 'enp4s0' -A 1 | tail -n 1 | awk -F ' ' '{print $2}')"
current="$(ifconfig | grep -i 'wlp5s0' -A 1 | tail -n 1 | awk -F ' ' '{print $2}')"
current_2="$(ifconfig | grep -i 'tun0' -A 1 | tail -n 1 | awk -F ' ' '{print $2}')"
bracket="|"
space=" "
testing=":"


case $externalIP in
	??*) up+=${bracket}${space}${externalIP}$space$bracket
esac

case $current_3 in
	*${testing}*) up=$up ;;
	??**) up+=$space$current_3$space$bracket ;;
esac


case $current in
	*${testing}*) up=$up ;;
	??*) up+=$space${current}$space$bracket
esac

case $current_2 in
	*${testing}*) up=$up ;;
	??*) up+=$space$current_2$space$bracket
esac
echo "<fc=$color><fn=1>$icon</fn> $up </fc>"

