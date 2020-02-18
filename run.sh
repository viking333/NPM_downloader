#Check if docker container exist. If it doesn't install it
if ! docker images npm_downloader | grep -q 'npm_downloader'; then
    echo "####### Building new docker container #######"
    docker build . -t npm_downloader
fi

#download packages using the list provided in packages.txt file
echo "####### Downloading NPM packages #######"
docker run  -v $PWD:/root/downloads -it --rm npm_downloader

#scanning packages
savscan -f -c -all -dn -archive packages/ && clamscan -r packages/
