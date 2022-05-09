I chose to build this container on Arch linux due to the fact it's an extremely small, bare bones distro
that's also easy to get set up to your needs. As such I could create an even smaller container to run the
game on.

I chose to use chocolate-doom as my program to run the actual DOOM wad, as I've personally found it to be
really easy and intuitive to use. However, going this route presented a few challenges. First off, makepkg
really doesn't like being run as root. It's a major security concern if the actual root user is executing
a package make and install. To get around this, the dockerfile creates a user whose only role in life is
to build the package. This micro user doesn't even have its own home directory and its default shell
doesn't actually exist. It literally just exists to be a nametag and fake moustache for our dockerfile so
that when it uses `sudo -u` to build the package as our micro user, it actually works.

The other major challenge I came across was actually getting the game to display when the container is
running. In short, a container needs to be run as privileged to have access to the machine's hardware.
Which does sort of feel like a violation of the concept of containerization. But that's ok, we can make
it run DOOM. Along with being privileged, the container also needs to have the $DISPLAY variable set in
its internal environment to match our machine's $DISPLAY variable and it also needs access to a valid
.Xauthority file because X11 is insistent that the ability to display on a screen should be inherently
tied to the presence of a secret file. As such we give the container access to our machine's .Xauthority
by way of the --volume flag.

The final hurdle major I needed to overcome came about while updating this Dockerfile. Upon running DOOM
after rebuilding the image with all the new updates, it crashed with a segfault. The segfault turned out
to be due to the arch base image not having pulseaudio installed and chocolate-doom not listing it as a
dependcy. After solving the segfault, however, DOOM still wasn't running properly. The window for the
game would open, then close shortly after without ever displaying anything. This turned out to be due
to xorg-server not being listed as a dependency for chocolate doom either. After installing both of these
packages, DOOM finally ran
