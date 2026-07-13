FROM quay.io/jupyter/scipy-notebook@sha256:e760028814b48e503f8991e20f89ad7ba2725b34ca7d937b104584b78f11169f

RUN mamba install -y -c conda-forge \
    jupyter-collaboration=4.4.0 \
    plotly=6.9.0 \
    panel=1.9.3 \
    dash=4.4.0 \
    nbgitpuller=1.3.0 \
    nbconvert=7.17.1 \
    nbformat=5.10.4 \
    requests=2.34.2 \
    jupyter-server-proxy=4.5.0 \
    jupyterlab-chat=0.22.1 \
    nodejs=26.5.0 \
    && mamba clean -afy

RUN jupyter lab build --dev-build=False && \
    jupyter lab clean -y && \
    rm -rf ~/.cache/yarn

RUN pip install --no-cache-dir jupyterlab_eigenpal_docx_viewer==0.1.0

RUN pip install --no-cache-dir \
    jupyterlab-lsp==5.3.0 \
    python-lsp-server[all]==1.14.0

RUN npm install --no-cache --save-dev unified-language-server@v4.1.0

RUN mkdir -p /opt/conda/share/jupyter/lab/settings/

COPY carpentries-jhub-overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json
