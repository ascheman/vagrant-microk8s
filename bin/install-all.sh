#!/bin/bash

set -eu

sudo=/bin/sudo
test ! -x "$sudo" && sudo=

# Only Update system once a dayÍ
test $(expr `stat -c %Y /var/lib/apt/periodic/update-success-stamp` + 84400) -lt $(date +%s) && $sudo apt-get update
test $(expr `stat -c %Y /var/lib/apt/extended_states` + 84400) -lt $(date +%s) && $sudo apt-get -yy upgrade

$sudo apt-get install libconfig-inifiles-perl

$sudo snap install microk8s --classic
$sudo usermod -a -G microk8s $USER
test -d ~/.kube && $sudo chown -f -R $USER ~/.kube

$sudo microk8s enable ingress helm3 storage dns

# $sudo echo 'k8s.galinews.intra.aschemann.net' >> /var/snap/

$sudo ln -sfn /vagrant/bin/* /usr/local/bin


