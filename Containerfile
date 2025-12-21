FROM quay.io/fedora/fedora-bootc:latest

RUN rm -rf /usr/local && \
	ln -sf /var/usrlocal /usr/local && \
	mkdir -p /etc/pki/containers

RUN dnf -y install 'dnf5-command(config-manager)' && \
	dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
	dnf -y group install virtualization && \
	dnf -y install \
	cockpit cockpit-ws cockpit-podman cockpit-selinux cockpit-machines \
	git neovim tree tmux rsync tailscale man-db systemd-resolved openvswitch \
	wireshark-cli haproxy keepalived && \
	dnf clean all && \
	systemctl enable cockpit.socket && \
	systemctl enable tailscaled && \
	systemctl enable systemd-resolved && \
	systemctl enable openvswitch

COPY etc/ /etc/
COPY cosign.pub /etc/pki/containers/fedora-bootc-custom.pub

RUN bootc container lint
