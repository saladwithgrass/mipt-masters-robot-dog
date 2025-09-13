FROM ros:humble
WORKDIR /ros_ws

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=:0
ENV XAUTHORITY=/tmp/.Xauthority


CMD ["/bin/bash"]
