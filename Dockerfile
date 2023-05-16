# Winthrop CSCI 460X Dockerfile for Tensorflow support

# start from base
FROM tensorflow/tensorflow:latest

MAINTAINER R. Paul Wiegand <wiegandrp@winthrop.edu>

# Install relevant software
RUN apt-get -yq update  --fix-missing
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y update

# Make sure we have additional python packages we need
ADD requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt


RUN DEBIAN_FRONTEND="noninteractive" apt-get -yqq install man less nano vim emacs git

# Create a user called "student" and
# enter the container as that user
RUN useradd -ms /bin/bash student
WORKDIR /home/student
USER student

# Map the student-home directory in the local dir to
# the /home/student user directory in the container
# when you start it, but starting it as follows:
#
#   ...run container  ...call it csci460tf  ...run interactively and map the volume                ... use this image
#   docker run        --name csci460tf     -it -v /full/path/to/persistent-homedir:/home/student  winthrop/csci210:v1
#
