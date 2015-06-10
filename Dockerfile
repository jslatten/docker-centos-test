FROM centos:centos6
MAINTAINER Justin Slatten <justin.slatten@gmail.com>

# Install packages and set up sshd
RUN rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN rpm -Uvh --force http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install openssh-server bzip2 unzip pwgen puppet tar gzip git
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
ADD puppet.conf /etc/puppet/puppet.conf
CMD ['echo "certname = `hostname`" >> /etc/puppet/puppet.conf']

# Add scripts
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
CMD ["/run.sh"]
