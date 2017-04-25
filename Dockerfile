# Source an appropriate base image here:
# FROM ...

# Install needed packages:
# RUN apk add --no-cache ...

# Add ContainerPilot and set its configuration file path:
ENV CONTAINERPILOT_VER 2.7.0
ENV CONTAINERPILOT file:///etc/containerpilot.json
RUN export CONTAINERPILOT_CHECKSUM=687f7d83e031be7f497ffa94b234251270aee75b \
    && curl -Lso /tmp/containerpilot.tar.gz \
        "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VER}/containerpilot-${CONTAINERPILOT_VER}.tar.gz" \
    && echo "${CONTAINERPILOT_CHECKSUM}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /usr/local/bin \
    && rm /tmp/containerpilot.tar.gz

# Install Consul agent:
ENV CONSUL_VER 0.7.2
ENV CONSUL_SHA256 aa97f4e5a552d986b2a36d48fdc3a4a909463e7de5f726f3c5a89b8a1be74a58
RUN curl -Lso /tmp/consul.zip "https://releases.hashicorp.com/consul/${CONSUL_VER}/consul_${CONSUL_VER}_linux_amd64.zip" \
    && echo "${CONSUL_SHA256}  /tmp/consul.zip" | sha256sum -c \
    && unzip /tmp/consul -d /usr/local/bin \
    && rm /tmp/consul.zip \
    && mkdir -p /opt/consul/config

# Install Consul template if needed:
ENV CONSUL_TEMPLATE_VER 0.15.0
ENV CONSUL_TEMPLATE_SHA256 b7561158d2074c3c68ff62ae6fc1eafe8db250894043382fb31f0c78150c513a
RUN curl -Lso /tmp/consul-template.zip "https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VER}/consul-template_${CONSUL_TEMPLATE_VER}_linux_amd64.zip" \
    && echo "${CONSUL_TEMPLATE_SHA256}  /tmp/consul-template.zip" | sha256sum -c \
    && unzip -d /usr/local/bin /tmp/consul-template.zip \
    && rm /tmp/consul-template.zip

# Copy configuration files and scripts into container:
COPY etc/* /etc/
COPY bin/* /usr/local/bin/

# override the parent entrypoint:
ENTRYPOINT []

# Spawn the primary process:
CMD [ "containerpilot", \
      "/usr/local/bin/EXECUTABLE" \
]
