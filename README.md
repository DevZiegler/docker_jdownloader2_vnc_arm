# Docker container for JDownloader 2 with VNC for ARM platforms
	docker_jdownloader2_vnc_arm: 
	A minimal installation of JDownloader2 as a docker container for ARM systems with VNC access
	
This project is a collection of different sources to create a minimal JDownloader 2 installation inside a Docker Container with VNC access for ARM based systems. It was only tested on a BananaPi M2+ (Armbian). But I think it  should also work without problems on a Raspberry Pi.

## Installation

- Creating the base image [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop)
	> **Note:** It is necessary to create the image on an x64 system, see @dmotte [fcwu/docker-ubuntu-vnc-desktop](https://github.com/fcwu/docker-ubuntu-vnc-desktop/issues/98#issuecomment-457348254). A minimal installation of a x64 Debian system inside a VirtualBox worked very well.

- Clone the repository

- Download Java for arm and put it in the root of the cloned repository
	> **Note:** As Jave version I used v8.231 (jdk-8u231-linux-arm32-vfp-hflt.tar.gz) . If you use an alternative version, change the filename and location in 'environment' and 'Dockerfile'!

- Now start the docker container with docker-compose up (alternatively with docker run ...)

## Generelle Info

It is a minimal configuration, and is open for numerous extensions. Ideas for this can be found here [jlesage/docker-jdownloader-2](https://github.com/jlesage/docker-jdownloader-2).

For remarks, ideas, improvements simply report.
