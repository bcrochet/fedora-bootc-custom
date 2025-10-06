FROM quay.io/fedora/fedora-bootc:latest

RUN rm -rf /usr/local && \
	ln -sf /var/usrlocal /usr/local

RUN dnf -y install \
	cockpit cockpit-ws cockpit-podman cockpit-selinux cockpit-machines \
	git neovim tree tmux \
	'dnf5-command(config-manager)' && \
	dnf clean all && \
	systemctl enable cockpit.socket

COPY etc/ /etc/

RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
	dnf -y install tailscale && \
	dnf clean all && \
	systemctl enable tailscaled


