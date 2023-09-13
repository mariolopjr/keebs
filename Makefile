USER = mariolopjr
KEYBOARDS = envoy

# keyboard hardware name
NAME_envoy = m256wh

all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
$(KEYBOARDS):
	# ensure submodule is initialized
	git submodule init --recursive

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/$(NAME_envoy)/keymaps/$(USER)

	# add new symlinks
	ln -s $(shell pwd)/src/keymaps/envoy qmk_firmware/keyboards/$(NAME_envoy)/keymaps/$(USER)

	# run lint check
	# cd qmk_firmware; qmk lint -km $(USER) -kb $(NAME_$@)

	# run build
	make BUILD_DIR=$(shell pwd)/build -j1 -C qmk_firmware $(NAME_$@):$(USER)

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/$(NAME_envoy)/keymaps/$(USER)

update:
	git submodule update --recursive --remote

clean:
	rm -rf /qmk_firmware/build/
	rm -rf ./build/
	rm -rf ./qmk_firmware/
