
REPO=gcr.io/trust-networks/smb-honeypot
VERSION=$(shell git describe | sed 's/^v//')
CYBERPROBE_VERSION=1.8.0

container: fedora-cyberprobe-${CYBERPROBE_VERSION}-1.fc27.x86_64.rpm
	docker build \
	    --build-arg CYBERPROBE_VERSION=${CYBERPROBE_VERSION} \
	    -t ${REPO}:${VERSION} -f Dockerfile .

push: container
	gcloud docker -- push ${REPO}:${VERSION}

fedora-cyberprobe-${CYBERPROBE_VERSION}-1.fc27.x86_64.rpm:
	wget -O$@ https://github.com/cybermaggedon/cyberprobe/releases/download/v${CYBERPROBE_VERSION}/$@

