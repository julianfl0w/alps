

rm example/alps/alps.stat/alps.csv

# Run the installer if necessary
# Check if /data/fsl directory does not exist
if [[ ! -d "/data/fsl" ]]; then
    echo "/data/fsl directory does not exist. Running fslinstaller.py..."
    python /data/fslinstaller.py
else
    echo "/opt/fsl directory already exists."
fi

# copy it to opt
echo "Copying fsl to opt (note: add to docker build)"
cp -r /data/fsl /opt

# update and install bc
echo "Updating and installing bc (basic calc)"
apt update
apt install -y bc
# were gonna be able to docker on the host from here
apt install -y docker.io

export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
bash -x /data/alps.sh -a /data/example/DM_1_001.nii.gz -b /data/example/DM_1_001.bval -c /data/example/DM_1_001.bvec -m /data/example/DM_1_001.json -t /data/example/JHU-ICBM-FA-1mm.nii.gz 
#-e eddy_cuda10.2
