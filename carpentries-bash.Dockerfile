FROM quay.io/jupyter/minimal-notebook@sha256:1fbcf7e462a634e141c541b15885081632a5bd062b4d25b254ecd42a512630f6

RUN mamba install -y -c conda-forge \
    jupyter-collaboration=4.4.1 \
    && mamba clean -afy

RUN pip install --no-cache-dir \
    git-credential-helpers==0.2 \
    nbgitpuller==1.3.0

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends man-db \
    && printf 'y\n' | unminimize \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y sudo && \
    echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${NB_USER} && \
    chmod 0440 /etc/sudoers.d/${NB_USER} && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_UID}
