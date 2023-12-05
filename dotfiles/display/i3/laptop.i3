# vim: nowrap ft=conf fdc=2 fdm=marker fdls=1

#=== GENERAL ================================================================{{{
floating_modifier Mod1

set $up    k
set $down  j
set $left  h
set $right l

#--- basic setup ------------------------------------------------------------{{{
bindsym Mod1+Shift+q  kill

# focus.
bindsym Mod1+$left   focus left
bindsym Mod1+$down   focus down
bindsym Mod1+$up     focus up
bindsym Mod1+$right  focus right

# move.
bindsym Mod1+Shift+$left   move left
bindsym Mod1+Shift+$down   move down
bindsym Mod1+Shift+$up     move up
bindsym Mod1+Shift+$right  move right

bindsym Mod1+Tab  workspace back_and_forth
workspace_auto_back_and_forth  yes

bindsym Mod1+v  split h
bindsym Mod1+c  split v

bindsym Mod1+f  fullscreen toggle

bindsym Mod1+space         focus mode_toggle
bindsym Mod1+Shift+space   floating toggle

bindsym Mod1+minus         scratchpad show
bindsym Mod1+Shift+minus   move scratchpad

# workspaces.
set $ws1  "1"
set $ws2  "2"
set $ws3  "3"
set $ws4  "4"
set $ws5  "5"
set $ws6  "6: x"
set $ws7  "7"
set $ws8  "8"
set $ws9  "9: net"
set $ws10 "10"

# switch.
bindsym Mod1+1 workspace $ws1
bindsym Mod1+2 workspace $ws2
bindsym Mod1+3 workspace $ws3
bindsym Mod1+4 workspace $ws4
bindsym Mod1+5 workspace $ws5
bindsym Mod1+6 workspace $ws6
bindsym Mod1+7 workspace $ws7
bindsym Mod1+8 workspace $ws8
bindsym Mod1+9 workspace $ws9
bindsym Mod1+0 workspace $ws10

# move to workspace.
bindsym Mod1+Shift+1 move container to workspace $ws1
bindsym Mod1+Shift+2 move container to workspace $ws2
bindsym Mod1+Shift+3 move container to workspace $ws3
bindsym Mod1+Shift+4 move container to workspace $ws4
bindsym Mod1+Shift+5 move container to workspace $ws5
bindsym Mod1+Shift+6 move container to workspace $ws6
bindsym Mod1+Shift+7 move container to workspace $ws7
bindsym Mod1+Shift+8 move container to workspace $ws8
bindsym Mod1+Shift+9 move container to workspace $ws9
bindsym Mod1+Shift+0 move container to workspace $ws10

bindsym Mod1+r mode "resize"
mode "resize" {
   bindsym Return mode "default"
   bindsym Escape mode "default"

   bindsym $left   resize shrink  width  10 px or 10 ppt
   bindsym $down   resize shrink  height 10 px or 10 ppt
   bindsym $up     resize grow    height 10 px or 10 ppt
   bindsym $right  resize grow    width  10 px or 10 ppt
}
#}}}

#--- gaps ----------------------------------------------------------------------
default_border pixel
gaps inner     20
gaps outer     0
smart_borders  on

#--- aesthetics ----------------------------------------------------------------
# class                 border    backgr.   text      indicator child_border
client.focused          #000000   #000000   #000000   #ffffff   #708090
client.focused_inactive #000000   #000000   #000000   #a0a0a0   #181818
client.unfocused        #000000   #000000   #000000   #000000   #000000
client.urgent           #000000   #000000   #000000   #000000   #000000
client.placeholder      #000000   #000000   #000000   #000000   #000000
#}}}

#=== USER CONFIG ============================================================{{{
#--- init ----------------------------------------------------------------------
exec_always --no-startup-id $HOME/.config/polybar/launch.sh
exec i3-msg "workspace $ws1; exec /usr/bin/alacritty"
exec i3-msg "workspace $ws9; exec /usr/bin/firefox-developer-edition"

#--- bindings ---------------------------------------------------------------{{{
# i3.
bindsym Mod1+Shift+c  reload
bindsym Mod1+Shift+r  restart

# applications.
bindsym Mod1+Return   exec /usr/bin/alacritty
bindsym Mod1+d        exec /usr/bin/rofi -show drun -mode drun
bindsym Mod1+e        exec /usr/bin/thunar
bindsym Mod1+F8       exec /usr/bin/systemctl suspend
bindsym Mod1+m        exec /usr/bin/alacritty --class 'float'  --title 'neomutt'  --command bash -lc neomutt

# volume.
bindsym Mod1+F1       exec /usr/bin/pulsemixer --toggle-mute --set-volume 0
bindsym Mod1+F2       exec /usr/bin/pulsemixer --change-volume -5
bindsym Mod1+F3       exec /usr/bin/pulsemixer --unmute --change-volume +5
bindsym Mod1+F4       exec /usr/bin/alacritty  --class 'float' --title 'pulsemixer' --command pulsemixer

# misc. utils:
bindsym Mod1+F11      exec ~/bin/br_step "-10"
bindsym Mod1+F12      exec ~/bin/br_step "10"
bindsym Mod1+s        exec ~/bin/screenshot
bindsym Mod1+less     exec ~/bin/fmt-reply
bindsym Mod1+greater  exec ~/bin/fmt-reply --prefix='>'
bindsym Mod1+b        exec ~/bin/bt_rofi                                    #}}}
#--- for_window -------------------------------------------------------------{{{
# `alacritty --class float`
for_window [ class="float" ] floating enable

for_window [ instance="pinentry-gtk-2"  ] floating enable, border pixel 1
for_window [ instance="Msgcompose"      ] floating enable
for_window [ instance="pavucontrol"     ] floating enable
for_window [ instance="syncthingtray"   ] floating enable
for_window [ instance="blueman-manager" ] floating enable

# Forces `picture-in-picture` windows to not have title bars
for_window [ class="firefoxdeveloperedition"                   ] border pixel 1
for_window [ class="firefoxdeveloperedition" instance="Places" ] floating enable

for_window [ class="Alacritty"      ] border pixel 1
for_window [ class="qutebrowser"    ] border pixel 1
for_window [ class="brogue"         ] floating enable, border pixel 1
for_window [ class="Dwarf_Fortress" ] floating enable, border pixel 1
for_window [ class="Anki"           ] floating enable, border pixel 1
for_window [ class="calibre"        ] floating enable
for_window [ class="mpv"            ] floating enable
for_window [ class="feh"            ] floating enable
for_window [ class="Bitwarden"      ] floating enable
for_window [ class="Thunar"         ] floating enable

for_window [ title="Wireshark · .*"        ] floating enable, border pixel 1, move position center
for_window [ title="^neomutt$"             ] resize set 1800 1600, move position center
for_window [ title="^pulsemixer$"          ] resize set 1200 500
for_window [ title="^Plover$"              ] floating enable
for_window [ title="Plover: Paper Tape"    ] floating enable
for_window [ title="Plover: Suggestions"   ] floating enable
for_window [ title="calibre - Preferences" ] border pixel 1
#}}}
#}}}
