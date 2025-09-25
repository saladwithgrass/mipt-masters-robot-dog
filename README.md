Here, we will be programming a robot dog to play big tennis.
Currently, we will try to achieve this with Unitree Go1 dog with Unitree Z1 manipulator.

# Starting and entering docker image
## Building a Docker image
First, you have to build an image like so:
```
docker compose build robot_dog
```

## Running the image
Before running the image, we have to allow access to display(**Linux only, i do
no know what to do for windows**):
```
xhost +local:
```
Then, to run the built image, type:
```
docker compose up -d robot_dog
```

## Accessing the image
To access the shell inside the image, type:
```
docker compose exec -it robot_dog bash
```
> [!NOTE]
> This command must be executed while in the same directory with compose.yaml

    
# Working with this repo
This repo contains a folder, called `robot_dog`. 
This folder is mounted to `/ros_ws/robot_dog/` in the image. 
Any change, done to this folder inside docker, will apply to the real folder
outside docker, "in the real world".

If you crate a file/directory anywhere outside `/ros_ws/robot_dog`, when you
stop docker conntainer, it will be **lost**. **Permanently**.

# Problems
## Which to use?
There are two big unitree repos:
`unitree_ros` and `unitree_mujoco`. unitree_ros has all the urdf and simulation
parameters that we need, but it runs gazebo with ros noetic. 
the other one does not have any useful urdf models, but it has an sdk and ros2
infrastructure.

Besides, we have not really found any combined urdf models. Maybe we should
look deeper.

> Answer: we're using unitree_mujoco with models from unitree_ros


Look, what i can salvage from unitree_ros: controls, models and sdk.
Next week: we need a sim with Go1.
