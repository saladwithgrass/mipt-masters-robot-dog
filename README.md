Here, we will be programming a robot dog to play big tennis.
Currently, we will try to achieve this with Unitree Go1 dog with Unitree Z1 manipulator.

# Starting and entering docker image
## Building a Docker image
First, you have to build an image like so:
```
docker compose build robot_dog
```

## Running the image
To run the built image, type:
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
