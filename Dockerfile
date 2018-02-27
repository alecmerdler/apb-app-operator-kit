FROM quay.io/alecmerdler/lostromos:ansible as lostromos
FROM quay.io/alecmerdler/my-test-apb:latest

ENV ANSIBLE_ROLES_PATH=/etc/ansible/roles:/opt/ansible/roles

ADD lostromos-config.yaml config.yaml

# Add our compiled binary and kubectl
COPY --from=lostromos /lostromos /lostromos
COPY --from=lostromos /usr/bin/kubectl /usr/bin/kubectl

ENTRYPOINT ["/lostromos", "start", "--config", "/config.yaml"]
