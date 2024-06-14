#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

cat <<EOF > /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:alternateved:keyd.repo
[copr:copr.fedorainfracloud.org:alternateved:keyd]
name=Copr repo for keyd owned by alternateved
baseurl=https://download.copr.fedorainfracloud.org/results/alternateved/keyd/fedora-\$releasever-\$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/alternateved/keyd/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

rpm-ostree install keyd mosh tmux

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
