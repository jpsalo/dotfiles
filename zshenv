typeset -U path path=(~/scripts $path)

export EDITOR="/usr/bin/nvim"

# export JAVA_HOME="/usr/lib/jvm/java-8-jdk"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export TERMINAL="/usr/bin/terminator"

export XDG_DATA_HOME=$HOME/.local/share/applications

export NODE_PATH="/usr/lib/node_modules"

SSH_AUTH_SOCK=`ss -xl | grep -o '/run/user/1000/keyring-qNyPds/ssh$'`
[ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK

export DOCKER_HOST=tcp://localhost:2375

# https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications#Theme_engines
export QT_STYLE_OVERRIDE=GTK+
export QT_QPA_PLATFORMTHEME=qgnomeplatform
