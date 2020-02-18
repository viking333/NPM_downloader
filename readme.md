# Requirements:

The program requires Docker installed on the machine. Also, the user account used to run the script needs to be in a docker group.
Docker tutorials can be found on the following [page](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

You will also need [Sophos for Linux](https://www.sophos.com/en-us/products/free-tools/sophos-antivirus-for-linux.aspx) and [ClamAV](https://www.clamav.net/documents/installing-clamav) anti-viruses 

#Usage

Add the required package names to the `packages.txt` file. 

The format should be a single package per single line.

For the latest version use name of the package only. for specific version use `Package_Name@Version_Number`

To start the process execute `run.sh`

Once completed, the packages and their dependencies can be found in the `packages` folder



P.S. The process will take a couple of minutes the first time it is being run. This is because the container will get downloaded and built. After that, any other runs will take significantly less time 
