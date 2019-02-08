FROM fedora:27

ARG CYBERPROBE_VERSION

RUN dnf -y update
RUN dnf -y install samba
RUN dnf -y install procps-ng

RUN useradd -c "Guest User" -d /dev/null -s /bin/false guest

RUN mkdir -p /vol/public /vol/secrets

COPY public /vol/public
COPY secrets /vol/secrets

COPY smb.conf /etc/samba/smb.conf

COPY fedora-cyberprobe-${CYBERPROBE_VERSION}-1.fc27.x86_64.rpm /
RUN dnf install -y /fedora-cyberprobe-${CYBERPROBE_VERSION}-1.fc27.x86_64.rpm
RUN rm -f /fedora-cyberprobe-${CYBERPROBE_VERSION}-1.fc27.x86_64.rpm
COPY cyberprobe.cfg /etc/cyberprobe.cfg

COPY start /start
RUN chmod 755 /start

EXPOSE 137/udp 138/udp 139 445

CMD "/start"

