#!/bin/bash
clear


tempdir=$(mktemp -d)

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install ubuntu-restricted-extras -y
sudo apt-get install gnome-icon-theme-full -y

sudo add-apt-repository ppa:yorba/ppa -y 
sudo apt-get sudo add-apt-repository ppa:smathot/cogscinl -y 
sudo add-apt-repository ppa:gottcode/gcppa -y 
sudo add-apt-repository ppa:webupd8team/sublime-text-2 -y 
sudo apt-get update

sudo apt-get install mendeleydesktop -y
sudo apt-get install shotwell -y 
sudo apt-get install ubuntu-restricted-extras -y 
sudo apt-get update -y 
sudo apt-get install sublime-text -y 
sudo apt-get install focuswriter -y 
sudo apt-get install opensesame -y 
sudo apt-get install vlc -y
sudo apt-get -y install libreoffice
apt-get -y install firefox

sudo apt-get install texlive -y 
sudo apt-get -y build-dep libcurl4-gnutls-dev
sudo apt-get -y install libcurl4-gnutls-dev






sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 -y

sudo echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" >>  /etc/apt/sources.list
sudo apt-get update
sudo apt-get install r-base


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

sudo dpkg -i $tempdir/rstudio-0.98.1103-amd64.deb
rm -fr $tempdir




sudo apt-get upgrade
