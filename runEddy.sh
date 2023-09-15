#!/usr/bin/bash
eddy=eddy_cuda10.2
FSLDIR=fsl
echo $indx > index.txt
pwd
ls
die
if [ $eddy == "1" ] && [ -f ${FSLDIR}/bin/eddy_openmp ]; then 
    echo "Found eddy_openmp! Running ${FSLDIR}/bin/eddy_openmp with default options"
    eddy_openmp --imain="$dwi1_processed" --mask=b0_brain_mask --acqp=acqparams.txt --index=index.txt --bvecs=bvec1 --bvals=bval1 --topup=my_topup_results --out=eddy_corrected_data
elif [ $eddy == "2" ] && [ -f ${FSLDIR}/bin/eddy ]; then 
    echo "Running ${FSLDIR}/bin/eddy with default options";
    eddy --imain="$dwi1_processed" --mask=b0_brain_mask --acqp=acqparams.txt --index=index.txt --bvecs=bvec1 --bvals=bval1 --topup=my_topup_results --out=eddy_corrected_data
elif [ $eddy == "3" ] && [ -f ${FSLDIR}/bin/eddy_correct ]; then 
    echo "Running ${FSLDIR}/bin/eddy_correct with default options";
    eddy_correct "$dwi1_processed" eddy_corrected_data 0 trilinear
elif [ "$eddy" == "eddy_cuda10.2" ] && [ -f "${FSLDIR}/bin/eddy_cuda10.2" ]; then 
    docker run -it --gpus all -v $(pwd):/data nvidia/cuda:12.2.0-base-ubuntu22.04 /data/fsl/bin/eddy_cuda10.2 --imain="$dwi1_processed" --mask=b0_brain_mask --acqp=acqparams.txt --index=index.txt --bvecs=bvec1 --bvals=bval1 --topup=my_topup_results --out=eddy_corrected_data

else echo "Eddy with user-specified eddy program ${FSLDIR}/bin/$eddy"
    "${FSLDIR}/bin/$eddy" --imain="$dwi1_processed" --mask=b0_brain_mask --acqp=acqparams.txt --index=index.txt --bvecs=bvec1 --bvals=bval1 --topup=my_topup_results --out=eddy_corrected_data
fi
