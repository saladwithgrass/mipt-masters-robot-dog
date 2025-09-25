FROM ros:humble
ENV ROS_WS /ros_ws
WORKDIR $ROS_WS
ADD ./robot_dog/ /ros_ws/robot_dog

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=:0
ENV XAUTHORITY=/tmp/.Xauthority

RUN sudo apt update && sudo apt upgrade -y
RUN sudo apt install -y libglfw3-dev \
                    libxinerama-dev \
                    libxcursor-dev \
                    libxi-dev \
                    libxkbcommon-dev

################
# BUILD MUJOCO #
################

ENV MUJOCO_DIR /ros_ws/robot_dog/mujoco
WORKDIR $MUJOCO_DIR
RUN mkdir -p build

WORKDIR $MUJOCO_DIR/build
RUN ls
RUN cmake ..
RUN make -j4

RUN sudo make install

WORKDIR $ROS_WS

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["/bin/bash"]
