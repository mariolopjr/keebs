#!/bin/bash

# ensure direnv is installed and works on respective platforms
if [[ "$(uname)" == "Darwin" ]]; then
    /opt/homebrew/bin/direnv allow . && eval "$(/opt/homebrew/bin/direnv export bash)"
elif [[ "$(uname)" == "Linux" ]]; then
    /usr/bin/direnv allow . && eval "$(/usr/bin/direnv export bash)"
fi

USER=mariolopjr

# keyboard hardware name
NAME_envoy=m256wh

# ensure submodule is initialized
git submodule update --init --recursive

# cleanup old files
rm -rf "qmk_firmware/keyboards/mode/${NAME_envoy}/keymaps/${USER}"

# copy files
cp .envrc .tool-versions Pipfile Pipfile.lock qmk_firmware/
cp -R "$(pwd)/src/keymaps/envoy" "qmk_firmware/keyboards/mode/${NAME_envoy}/keymaps/${USER}"

# run build
cd qmk_firmware || exit
qmk compile -kb "mode/${NAME_envoy}" -km "$USER"

# copy built firmware
cd .. || exit
mv "qmk_firmware/mode_${NAME_envoy}_${USER}.bin" build/

# cleanup old files
rm -rf "qmk_firmware/keyboards/mode/${NAME_envoy}/keymaps/${USER}"
rm qmk_firmware/.envrc qmk_firmware/.tool-versions qmk_firmware/Pipfile qmk_firmware/Pipfile.lock
