FROM quay.io/jupyter/scipy-notebook:latest

RUN mamba install -y -c conda-forge \
    jupyter-collaboration \
    plotly \
    panel \
    dash \
    nbconvert \
    nbformat \
    requests \
    jupyter-server-proxy \
    && mamba clean -afy

RUN mamba install -y -c conda-forge nodejs && \
    jupyter lab build --dev-build=False && \
    jupyter lab clean -y && \
    mamba clean -afy && \
    rm -rf ~/.cache/yarn
