FROM quay.io/fedora/fedora-bootc:latest

RUN dnf -y install cockpit cockpit-ws cockpit-podman git neovim tree && \
	dnf clean all && \
	systemctl enable cockpit.socket

COPY etc etc

