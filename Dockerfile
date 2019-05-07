FROM centos
MAINTAINER Md. Zahirul Haque (zahirul.arb@gmail.com)
RUN yum update -y
RUN yum groupinstall -y "Development tools"
RUN yum install wget -y
RUN yum install tar -y
RUN yum install -y wget kernel-devel-$(uname -r) kernel-headers-$(uname -r) libX11 libGLU libSM
CMD sh -c 'echo setenv SPM_HOST licensing.migenius.com > /etc/profile.d/spm.csh'
CMD sh -c 'echo export SPM_HOST=licensing.migenius.com > /etc/profile.d/spm.sh'

#Change the licence port number 1389 with your port provided by migenious
CMD sh -c 'echo -e "mi-spm\t1389/tcp\t# migenius SPM License Server" >> /etc/services' 

# Enable following two if grpahics is available exactly
#RUN wget http://us.download.nvidia.com/tesla/410.79/NVIDIA-Linux-x86_64-410.79.run
#RUN sh ./NVIDIA-Linux-x86_64-410.79.run -a

RUN yum install wget -y
RUN yum install tar -y
CMD mkdir -p /usr/local/migenius
CMD cd /usr/local/migenius
RUN wget http://download.migenius.com/releases/RealityServer/rsws-51-2017.251.tgz
RUN tar zxvf rsws-51-2017.251.tgz
RUN chown -R root:root rsws-51-2017.251
RUN ln -s rsws-51-2017.251 rsws
RUN cd rsws
CMD . /etc/profile.d/spm.sh
CMD ./realityserver_ws > rs.log 2>&1 &

EXPOSE 8080
