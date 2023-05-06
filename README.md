### Install the following dependenices in the docker image
# 
# curl iproute2 sshfs unzip less groff 
# Install kubectl from https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl
#
# Install AWS CLI from https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
# 
# Install the above tools, unpack and make it available in the PATH executable
###

RUN apt-get update && apt-get install -y curl iproute2 sshfs unzip less groff

RUN curl -LO https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl &&  chmod +x kubectl && mv kubectl /usr/local/bin

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip aws

ENV PATH="${PATH}:/usr/local/bin"

CMD ["/bin/bash"]

#Commands to create image:
docker build -t intuitivedockerimage .

#Commands to create/start container:
docker run -it -d intuitivedockerimage
docker ps

#Command to upload image to DockerHub Registery:
docker tag intuitivedockerimage myusername/myrepository:1.0
docker push myusername/myrepository:1.0
