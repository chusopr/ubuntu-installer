#!/bin/bash

# If the script is being executed as a non-root user, become root with sudo
if [ $UID != 0 ]
then
  # The script itself is executed again with sudo
  # sudo is called with exec so current script execution is replaced by
  # the one executed with sudo
  exec sudo $0
fi

clear


tempdir=$(mktemp -d)

apt-get update
apt-get upgrade -y
apt-get install ubuntu-restricted-extras gnome-icon-theme-full -y

add-apt-repository ppa:yorba/ppa -y 
add-apt-repository ppa:smathot/cogscinl -y 
add-apt-repository ppa:gottcode/gcppa -y 
add-apt-repository ppa:webupd8team/sublime-text-2 -y 
apt-get update

apt-get install mendeleydesktop shotwell ubuntu-restricted-extras -y 
apt-get update -y 
apt-get install sublime-text focuswriter opensesame vlc libreoffice firefox texlive -y 
apt-get -y build-dep libcurl4-gnutls-dev
apt-get -y install libcurl4-gnutls-dev






apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 -y

echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" >>  /etc/apt/sources.list
apt-get update
apt-get install r-base


cat << EOF > $tempdir/sc.R
	pack <- c("dlm","parallel" ,"languageR","boot","arm" ,"effects","doBy","Hmisc","RLRsim","influence.ME","pbkrtest","GPArotation", "lmerTest", "ggplot2", "dplyr", "reshape2", "plyr", "xtable", "psych", "car", "foreign", "gdata", "catR", "knitr", "psychometric", "gmodels", "lme4","AICcmodavg" )

	req <- function(pack){
 		 not.installed <- !pack %in% installed.packages()
		  for.install <- pack[not.installed]
		  lapply(for.install, install.packages)
		  lapply(pack, require, character.only=T)
			  }
		req(pack)
EOF


R CMD BATCH $tempdir/sc.R



wget -P $tempdir http://download1.rstudio.org/rstudio-0.98.1103-amd64.deb

dpkg -i $tempdir/rstudio-0.98.1103-amd64.deb
rm -fr $tempdir




apt-get upgrade
