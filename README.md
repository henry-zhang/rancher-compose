###recovery rancher services from zero to fully health

##check kernel version

uname -a

##kernel update to 4.x

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

yum --disablerepo=\* --enablerepo=elrepo-kernel install -y kernel-lt.x86_64 -y

##switch to use new kernel

grub2-set-default 'CentOS Linux (4.4.140-1.el7.elrepo.x86_64) 7 (Core)'

grub2-editenv list


##check docker verion,if it is not 17.X ,please remove

docker -v 

yum remove docker-* -y

rm -rf /var/lib/docker

##disable selinux

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config


##reboot os try to install current 17.X docker

reboot

curl https://releases.rancher.com/install-docker/17.06.sh | sh

##update firewall to trust docker0 

nmcli connection modify docker0 connection.zone trusted

systemctl stop NetworkManager.service

firewall-cmd --permanent --zone=trusted --change-interface=docker0

systemctl start NetworkManager.service

nmcli connection modify docker0 connection.zone trusted

systemctl stop docker.service

systemctl enable docker


##clean exist rancher , if need

docker ps -qa|xargs docker rm -f ;systemctl stop docker ; umount /var/lib/rancher/volumes;rm /var/lib/rancher/ -rf;rm -rf /var/lib/docker


##re-join rancher cluster ,please update the accesskey,like "CD11B126A8F04:1400000:d4TYnHHp9v7meohLPqPEduAyM7I"

sudo docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.5 https://rancher.engage.newdevops.net/v1/scripts/CD11B050AF04:151460000:d4TYnmeohLPqPEduAyM7I

##check agent logs

docker logs rancher-agent -f 


##add rancher API token,you can get it from web console api page

nano env.sh

##export API

source env.sh

##build/recovery/update service stacks

cd mysql

../bin/new-deploy.sh mysql

