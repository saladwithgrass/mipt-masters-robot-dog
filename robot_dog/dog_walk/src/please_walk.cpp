#include <unitree/robot/go2/sport/sport_client.hpp>
#include <unistd.h>

int main(int argc, char **argv) {
  if (argc == 0) {
    std::cout << "Usage: " << argv[0] << " networkInterface" << std::endl;
    exit(-1);
  }

  if (argc < 2) {
    std::cout << "Connecting as local to interface \"lo\".\n";
    unitree::robot::ChannelFactory::Instance()->Init(1, "lo");
  } else {
    unitree::robot::ChannelFactory::Instance()->Init(0, argv[1]);
  }

//argv[1] is network interface of the robot
  
  //Create a sports client object
  unitree::robot::go2::SportClient sport_client();
  sport_client.SetTimeout(10.0f);//Timeout time
  sport_client.Init();

  sport_client.StandUp(); //Special action, robot dog sitting down
  sleep(3);//delay 3s
  sport_client.StandDown(); //Restore
  sleep(3);

  return 0;
}