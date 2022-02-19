FROM continuumio/miniconda3:4.10.3

# Update the image to the latest packages
RUN apt-get --allow-releaseinfo-change update && apt-get upgrade -y

RUN apt-get install --no-install-recommends -y build-essential libz-dev swig git-lfs cmake
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Choose 'cpu' or 'gpu'
ARG DEVICE=cpu
COPY install/mala_${DEVICE}_base_environment.yml .
RUN conda env create -f mala_${DEVICE}_base_environment.yml && rm -rf /opt/conda/pkgs/*

RUN echo "source activate mala-${DEVICE}" > ~/.bashrc
ENV PATH /opt/conda/envs/mala-${DEVICE}/bin:$PATH
