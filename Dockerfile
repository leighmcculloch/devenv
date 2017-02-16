FROM ubuntu:16.10

COPY . /setup
RUN cd /setup/setup-system && ./setup.sh
 
RUN adduser-github leighmcculloch \
 && adduser leighmcculloch sudo
