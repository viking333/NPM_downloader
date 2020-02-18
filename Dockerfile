FROM centos:7

RUN curl -sL https://rpm.nodesource.com/setup_6.x | sh - && yum install -y nodejs 
WORKDIR /root/downloads
COPY download.py /root/download.py
ENTRYPOINT ["python", "/root/download.py", "packages.txt"]
