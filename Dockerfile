#FROM pytorch/pytorch
FROM housebw/darknet
#FROM nvidia/cuda:10.0-base-ubuntu16.04

FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04
ENV LANG C.UTF-8
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        curl \
        sudo \
        bzip2 \
        libx11-6 \
        cmake \
        wget \
        git \
        vim \
        fish \
        libsparsehash-dev \
        && \
# ==================================================================
# python
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.6 \
        python3.6-dev \
        python3-distutils-extra \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    $PIP_INSTALL \
        setuptools \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        cloudpickle \
        scikit-learn \
        matplotlib \
        Cython \
        pillow \
        && \
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

RUN pip install tensorflow==1.14 tensorflow-gpu==1.14 
RUN apt-get update
RUN apt-get install -y libsm6 libxrender1 libfontconfig1 libxext6
RUN pip install opencv-python pytest requests codecov pytest-cov

# Copying code to the container
COPY ./darknet /darknet 
WORKDIR /darknet
RUN make
RUN chmod +x test_multiple_list_images.sh
RUN chmod +x test_single_image.sh
RUN chmod +x train.sh