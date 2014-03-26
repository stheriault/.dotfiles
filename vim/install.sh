#/usr/bin/env bash

VIM_DIR="${HOME}/.vim"
BUNDLE_DIR="${VIM_DIR}/bundle"
PATHOGEN_DIR="${BUNDLE_DIR}/pathogen"

if [[ -z "$script" ]]
then
    PLUGINS_LIST_DIR="`dirname $0`/plugins"
else
    PLUGINS_LIST_DIR="`dirname \"$script\"`/plugins"
fi

# function to install the vim plugins
function install_plugin() {
    while read line
    do
        if echo $line | grep -q "DEPENDS"
        then
            install_plugin `echo $line | awk '{ print $2 }'`
        else
            plugin_dir="${BUNDLE_DIR}/$1"
            if [ ! -d $plugin_dir ]
            then
                git clone $line $plugin_dir
                echo " "
            else
                pushd $plugin_dir > /dev/null
                echo "fetching $1"
                git pull
                echo " "
                popd > /dev/null
            fi
        fi
    done < $1
}


# install pathogen for managing vim plugins
if [ ! -d "${PATHOGEN_DIR}/.git" ]
then
    git clone https://github.com/tpope/vim-pathogen.git $PATHOGEN_DIR
else
    pushd $PATHOGEN_DIR > /dev/null
    git fetch
    popd > /dev/null
fi

# install all the plugins in the plugin directory
pushd $PLUGINS_LIST_DIR > /dev/null
for plugin in *
do
    install_plugin $plugin
done
popd > /dev/null
