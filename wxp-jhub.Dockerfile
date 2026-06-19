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
    nodejs \
    && mamba clean -afy

RUN jupyter lab build --dev-build=False && \
    mamba remove -n base -y nodejs && \
    jupyter lab clean && \
    mamba clean -afy && \
    rm -rf ~/.cache/yarn
