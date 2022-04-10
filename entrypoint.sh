#!/bin/sh

if [ ! -d ${USER_HOME} ]
then
  mkdir -p ${USER_HOME}
fi

groupadd -g ${USER_GID} ${USER_GROUP} 
useradd -u ${USER_UID} -g ${USER_GID} -d ${USER_HOME} -s ${USER_SHELL} ${USER_NAME}

chown ${USER_UID}:${USER_GID} ${USER_HOME}

# Install vim-plug if not installed
if [ ! -d ${USER_HOME}/.local/share/nvim/site/autoload ]
then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$USER_HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  git clone --depth 1 https://github.com/plucio/neovim-configuration.git ${USER_HOME}/.config/nvim/

  chown -R ${USER_UID}:${USER_GID} ${USER_HOME}/.local/
  chown -R ${USER_UID}:${USER_GID} ${USER_HOME}/.config/
fi

export PATH=${PATH}:/usr/local/go/bin

cd ${WORKSPACE} && su-exec ${USER_NAME} nvim "$@"
