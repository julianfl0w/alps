# Docker out of Docker (DooD) setup
docker run -it -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/data mrtrix3/mrtrix3 bash -x /data/runScript.sh
#-e eddy_cuda10.2
