USER = mariolopjr
KEYBOARDS = envoy

# keyboard hardware name
NAME_envoy = m256wh

all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
$(KEYBOARDS):
	# ensure submodule is initialized
	git submodule update --init --recursive

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/mode/$(NAME_envoy)/keymaps/$(USER)

	# add new symlinks
	ln -s $(shell pwd)/src/keymaps/envoy qmk_firmware/keyboards/mode/$(NAME_envoy)/keymaps/$(USER)

	# run build
	cd qmk_firmware
	qmk compile -kb mode/$(NAME_envoy) -km $(USER)

	# cleanup old symlinks
	rm -rf qmk_firmware/keyboards/mode/$(NAME_envoy)/keymaps/$(USER)

update:
	git submodule update --recursive --remote --merge

clean:
	rm -rf /qmk_firmware/build/
	rm -rf ./build/
	rm -rf ./qmk_firmware/
