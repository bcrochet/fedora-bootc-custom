FROM quay.io/fedora/fedora-bootc:latest

RUN rm -rf /usr/local && \
	ln -sf /var/usrlocal /usr/local

RUN dnf -y install 'dnf5-command(config-manager)' && \
	dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
	dnf -y group install virtualization && \
	dnf -y install \
	cockpit cockpit-ws cockpit-podman cockpit-selinux cockpit-machines \
	git neovim tree tmux rsync tailscale && \
	dnf clean all && \
	systemctl enable cockpit.socket && \
	systemctl enable tailscaled

COPY etc/ /etc/



