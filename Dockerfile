FROM debian as openvpnawsfork

WORKDIR /tmp
RUN apt-get update && apt-get install -qqy curl binutils xz-utils
RUN curl https://d20adtppz83p9s.cloudfront.net/GTK/latest/awsvpnclient_amd64.deb -o /tmp/awsvpnclient_amd64.deb
RUN ar xv /tmp/awsvpnclient_amd64.deb
RUN tar xvf data.tar.xz

FROM debian

WORKDIR /

COPY --from=openvpnawsfork /tmp/opt/awsvpnclient/Service/Resources/openvpn/acvc-openvpn /openvpn

RUN apt-get update && apt-get install -qqy curl tar net-tools dnsutils openvpn openvpn-systemd-resolved iproute2 

RUN curl -L https://golang.org/dl/go1.15.4.linux-amd64.tar.gz -o go.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

COPY server.go .

RUN go build server.go

ADD entrypoint.sh /
ADD update-systemd-resolved /etc/openvpn/scripts/
ADD routedev /usr/local/bin/routedev

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"] 