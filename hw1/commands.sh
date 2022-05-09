# install qemu
brew install qemu

# install ubuntu
sudo qemu-system-x86_64 -m 4096 -boot d -accel hvf -cpu EPYC -smp cores=4,threads=2 -boot strict=on -hda ubuntu.img -cdrom ubuntu-20.04.4-live-server-amd64.iso

# run after install
sudo qemu-system-x86_64 -m 4096 -boot d -accel hvf -cpu host -smp cores=2,threads=2 -nic user,model=virtio,hostfwd=tcp:127.0.0.1:8888-0.0.0.0:22 -boot strict=on -hda ubuntu.img

# Dock run after install
sudo docker run --rm -it --cpuset-cpus="0-1" -m 2G --entrypoint /bin/sh zyclonite/sysbench