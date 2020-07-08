FROM docker.io/s390x/clefos:latest

#Update OS Packages
#RUN  rpmkeys --import "http://pool.sks-keyservers.net/pks/lookup?op=get&search=0x3fa7e0328081bff6a14da29aa6a19b38d3d831ef"
#RUN su -c 'curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo'
RUN yum install mono-devel xsp -y

#Testing -1 
RUN csharp -e 'new System.Net.WebClient ().DownloadString ("https://www.nuget.org")'

#Testing -2
RUN mkdir -p scripts
ADD hello.cs scripts/hello.cs
RUN mcs scripts/hello.cs
RUN mono scripts/hello.exe


VOLUME /app
WORKDIR /usr/lib/xsp/test
#ADD samp.aspx app/samp.aspx

EXPOSE 9090
ENTRYPOINT [ "xsp4","--port","9090","--nonstop"]
