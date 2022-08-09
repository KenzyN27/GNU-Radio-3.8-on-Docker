# Setup the environment
FROM ubuntu:20.04
LABEL maintainer="someone@xyz.xyz"
LABEL version="1.0"
ENV DEBIAN_FRONTEND noninteractive

# Clean and update the dependency list
RUN apt-get clean
RUN apt-get update

# Install the dependencies
RUN apt-get install -qy software-properties-common
RUN apt-get install -qy python3.8
RUN apt-get install -qy git
RUN apt-get install -qy cmake
RUN apt-get install -qy g++
RUN apt-get install -qy libboost-all-dev
RUN apt-get install -qy libgmp-dev
RUN apt-get install -qy swig
RUN apt-get install -qy python3-numpy
RUN apt-get install -qy python3-mako
RUN apt-get install -qy python3-sphinx
RUN apt-get install -qy python3-lxml
RUN apt-get install -qy doxygen
RUN apt-get install -qy libfftw3-dev
RUN apt-get install -qy libsdl1.2-dev
RUN apt-get install -qy libgsl-dev
RUN apt-get install -qy libqwt-qt5-dev
RUN apt-get install -qy libqt5opengl5-dev
RUN apt-get install -qy python3-pyqt5
RUN apt-get install -qy liblog4cpp5-dev
RUN apt-get install -qy libzmq3-dev
RUN apt-get install -qy python3-yaml
RUN apt-get install -qy python3-click
RUN apt-get install -qy python3-click-plugins
RUN apt-get install -qy python3-zmq
RUN apt-get install -qy python3-scipy
RUN apt-get install -qy python3-gi
RUN apt-get install -qy python3-gi-cairo
RUN apt-get install -qy gir1.2-gtk-3.0
RUN apt-get install -qy libcodec2-dev 
RUN apt-get install -qy libgsm1-dev

# Clean apt-get to make image as small as possible
RUN apt-get -qy autoremove

# Install GNU Radio 3.8
RUN add-apt-repository -y ppa:gnuradio/gnuradio-releases-3.8
RUN apt-get install -y sudo

# Make a new user with a passwd for GS to use. User is groundstation, passwd is groundstation
RUN useradd --create-home --shell /bin/bash -G sudo groundstation
RUN echo 'groundstation:groundstation' | chpasswd

# Set home dir
RUN mkdir /home/groundstation/stuff && chown groundstation /home/groundstation/stuff
RUN apt-get update
RUN apt-get install -y gnuradio
RUN echo Gnu Radio installed

# Set User
USER groundstation
WORKDIR /home/groundstation

# Fix the python path for gnuradio
ENV PYTHONPATH "${PYTHONPATH}:/usr/local/lib/python3/dist-packages"

# Confirms successful build
RUN echo GNU Radio 3.8 Container Started.

# Run the bash terminal after. Using this CMD at the end of the file allows for the terminal to be open after the container is started.
CMD bash
