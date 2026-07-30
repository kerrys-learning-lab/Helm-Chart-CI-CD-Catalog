# ============================================================================
FROM docker.io/rockylinux/rockylinux:10.2-ubi


# ----------------------------------------------------------------------------
RUN dnf install -y  git  \
                    jq


# ----------------------------------------------------------------------------
ENV HELM_URL=https://get.helm.sh
ENV HELM_VERSION=v4.2.0
ENV HELM_UNITTEST_PLUGIN_URL=https://github.com/helm-unittest/helm-unittest.git
ENV HELM_PUSH_PLUGIN_URL=https://github.com/chartmuseum/helm-push
RUN mkdir -p ${INSTALL_DIR}/helm-${HELM_VERSION}  && \
    cd ${INSTALL_DIR}/helm-${HELM_VERSION} && \
    curl -fsSLO ${HELM_URL}/helm-${HELM_VERSION}-linux-amd64.tar.gz  && \
    tar --extract --auto-compress --file helm-${HELM_VERSION}-linux-amd64.tar.gz  && \
    ln -s ${INSTALL_DIR}/helm-${HELM_VERSION}/linux-amd64/helm  /usr/local/bin/helm  && \
    helm plugin install --verify=false ${HELM_UNITTEST_PLUGIN_URL}  && \
    helm plugin install --verify=false ${HELM_PUSH_PLUGIN_URL}
