Docker container that will help to build AOSP ROM.

Main requirements:
- Docker engine
- Case sensitive file system
- 16+ GB of RAM
- 200-300 GB of free space

# Build container
```
docker build -t aosp-rom-builder .
```

# Run
```
docker run --name aosp-rom-builder -it \
  -v /[path_to_rom_src]/:/home/builder/src \
  -v ~/.ssh/:/home/builder/.ssh/ \
  -v $(pwd)/local_manifests/:/home/builder/local_manifests/ \
  aosp-rom-builder
```

# Build ROM
```
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-19.1

repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

source build/envsetup.sh

# if you want to include microg
export WITH_GMS=true

# user or userdebug
lunch lineage_sweet-user

make bacon -j$(nproc --all) | tee build-$(date "+%Y%m%d_%H%M%S").log
```
