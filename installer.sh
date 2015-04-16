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


apt-get -y install ttf-mscorefonts-installer
apt-get -y install ubuntu-restricted-addons
apt-get -y install gstreamer0.10-plugins-bad-multiverse
apt-get -y install libavcodec-extra-53
apt-get -y install unrar gnome-icon-theme-full

add-apt-repository -y  ppa:yorba/ppa
add-apt-repository -y  ppa:smathot/cogscinl
add-apt-repository -y  ppa:gottcode/gcppa
add-apt-repository -y  ppa:webupd8team/sublime-text-2
echo "Updating"
apt-get update &> /dev/null

apt-get -y install sublime-text focuswriter opensesame vlc libreoffice firefox texlive || echo "Writers and Firefox not installed"
apt-get -y build-dep libcurl4-gnutls-dev
apt-get -y install libcurl4-gnutls-dev



apt-get upgrade && echo "Actualización correcta" || echo "Actualización fallida"

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" >>  /etc/apt/sources.list
echo "updating"
apt-get update &> /dev/null
apt-get install r-base


cat << EOF > $tempdir/sc.R
	pack <- c("dlm","parallel" ,"languageR","boot","arm" ,"effects","doBy","Hmisc","RLRsim","influence.ME","pbkrtest","GPArotation", "lmerTest", "ggplot2", "dplyr", "reshape2", "plyr", "xtable", "psych", "car", "foreign", "gdata", "catR", "knitr", "psychometric", "gmodels", "lme4","AICcmodavg" )



	req <- function(pack){
 		 not.installed <- !pack %in% installed.packages()
		  for.install <- pack[not.installed]
		  install.packages_2 <- function(arg){ install.packages(arg, repos="http://cran.rstudio.com/") }
		  lapply(for.install, install.packages_2)

			  }
		req(pack)
EOF


R CMD BATCH $tempdir/sc.R



wget -P $tempdir http://download1.rstudio.org/rstudio-0.98.1103-amd64.deb

dpkg -i $tempdir/rstudio-0.98.1103-amd64.deb
rm -fr $tempdir




apt-get upgrade || echo "Upgrade failed" && echo "Upgrade OK"
