FROM ros:humble
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
ENV ROS_WS /root/
WORKDIR $ROS_WS

ENV REQUIRED_MODULES $ROS_WS/required_modules/
COPY ./required_modules/unitree_modules/ $REQUIRED_MODULES/unitree_modules
COPY ./required_modules/mujoco/ $REQUIRED_MODULES/mujoco

ARG DEBIAN_FRONTEND=noninteractive

ENV DISPLAY=:0
ENV XAUTHORITY=/tmp/.Xauthority

RUN sudo apt update && sudo apt upgrade -y
RUN sudo apt install -y libglfw3-dev \
                    libxinerama-dev \
                    libxcursor-dev \
                    libxi-dev \
                    libxkbcommon-dev \
                    libboost-all-dev \
                    libyaml-cpp-dev \
                    ros-humble-rosidl-generator-dds-idl\
                    neovim\
                    nano


ENV MUJOCO_DIR $REQUIRED_MODULES/mujoco
ENV UNITREE_MODULES_DIR $REQUIRED_MODULES/unitree_modules
################
# BUILD MUJOCO #
################

WORKDIR $MUJOCO_DIR
RUN mkdir -p build

WORKDIR $MUJOCO_DIR/build
RUN cmake ..
RUN make -j8

RUN sudo make install

WORKDIR $UNITREE_MODULES_DIR
#######################
# BUILD unitreer_ros2 #
#######################

ENV UNITREE_ROS2_DIR $UNITREE_MODULES_DIR/unitree_ros2
WORKDIR $UNITREE_ROS2_DIR
WORKDIR cyclonedds_ws
RUN colcon build --packages-select cyclonedds
WORKDIR ..
RUN source /opt/ros/humble/setup.bash && colcon build
RUN echo "source $UNITREE_ROS2_DIR/install/setup.bash" >> ~/.bashrc

WORKDIR $UNITREE_MODULES_DIR
######################
# BUILD unitree_sdk2 #
######################

WORKDIR unitree_sdk2
RUN mkdir -p build
WORKDIR build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/opt/unitree_robotics
RUN sudo make install


WORKDIR $UNITREE_MODULES_DIR
########################
# BUILD unitree_mujoco #
########################

WORKDIR unitree_mujoco/simulate
RUN mkdir -p build
WORKDIR build
RUN cmake ..
RUN make -j8

WORKDIR example/ros2
RUN source /opt/ros/humble/setup.bash && \
    source $UNITREE_ROS2_DIR/install/setup.bash && \
    colcon build



WORKDIR $ROS_WS


CMD ["/bin/bash"]

# COPY ./required_modules/ $REQUIRED_MODULES
