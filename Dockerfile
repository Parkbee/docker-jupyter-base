# Sample here: https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/master/images/singleuser-sample/Dockerfile
# Image tag hash from 2018-09-04
FROM jupyter/scipy-notebook:137a295ff71b

# Upgrade pip
RUN pip install --upgrade pip

# Copy additional requirements
COPY requirements.txt /requirements.txt

# Install additional requirements
RUN while read requirement; do conda install --yes $requirement || pip install $requirement; done < /requirements.txt && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
