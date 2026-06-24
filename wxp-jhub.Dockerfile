FROM quay.io/jupyter/scipy-notebook@sha256:12f4ac376725d3bc7cd64b35e8c47c67b6037646ab4714276fc53b9ffba2001b

RUN mamba install -y -c conda-forge \
    jupyter-collaboration=4.4.1 \
    plotly=6.8.0 \
    panel=1.9.3 \
    dash=4.2.0 \
    nbconvert=7.17.1 \
    nbformat=5.10.4 \
    requests=2.34.2 \
    jupyter-server-proxy=4.5.0 \
    && mamba clean -afy

RUN mamba install -y -c conda-forge nodejs=26.3.1 && \
    jupyter lab build --dev-build=False && \
    jupyter lab clean -y && \
    mamba clean -afy && \
    rm -rf ~/.cache/yarn

RUN pip install --no-cache-dir jupyterlab_eigenpal_docx_viewer==0.1.0

RUN pip install --no-cache-dir \
    jupyterlab-lsp==2.3.1 \
    python-lsp-server==1.14.0

RUN mkdir -p /opt/conda/share/jupyter/lab/settings/

COPY wxp-jhub-overrides.json /opt/conda/share/jupyter/lab/settings/overrides.json
