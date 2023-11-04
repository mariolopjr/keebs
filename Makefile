USER = mariolopjr
KEYBOARDS = envoy

# keyboard hardware name
NAME_envoy = m256wh

all: $(KEYBOARDS)

.PHONY: $(KEYBOARDS)
$(KEYBOARDS):
	# ensure submodule is initialized
	git submodule update --init --recursive

	# cleanup old files
	rm -rf qmk_firmware/keyboards/mode/$(NAME_envoy)/keymaps/$(USER)

	# copy files
	cp -R $(shell pwd)/src/keymaps/envoy qmk_firmware/keyboards/mode/$(NAME_envoy)/keymaps/$(USER)

	# run build
	cd qmk_firmware; util/docker_build.sh mode/$(NAME_envoy):$(USER)

	# cleanup old files
	rm -rf qmk_firmware/keyboards/mode/$(NAME_envoy)/keymaps/$(USER)

update:
	git submodule update --recursive --remote --merge

clean:
	rm -rf /qmk_firmware/build/
	rm -rf ./qmk_firmware/
