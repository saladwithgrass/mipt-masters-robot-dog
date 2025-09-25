FROM ros:humble
WORKDIR /ros_ws

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=:0
ENV XAUTHORITY=/tmp/.Xauthority

RUN sudo apt update && sudo apt upgrade -y
RUN sudo apt install -y libglfw3-dev \
                    libxinerama-dev \
                    libxcursor-dev \
                    libxi-dev \
                    libxkbcommon-dev

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["/bin/bash"]
