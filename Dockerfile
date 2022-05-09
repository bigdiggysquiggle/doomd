#NOTE: must provide your own DOOM.WAD

FROM archlinux:base

COPY DOOM.WAD /usr/share/doom.wad

RUN pacman -Syu --noconfirm git sudo binutils file patch gcc pkg-config awk make fakeroot pulseaudio xorg-server; \
	useradd --no-create-home --shell=/bin/false build && usermod -L build; \
	echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
	echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
	mkdir builds && git clone https://aur.archlinux.org/chocolate-doom.git builds/chocolate-doom; \
	chmod 777 builds builds/chocolate-doom; \
	cd /builds/chocolate-doom; \
	sudo -u build makepkg -si --noconfirm --skippgpcheck

ENTRYPOINT chocolate-doom -iwad /usr/share/doom.wad -window
