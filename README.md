# CentOS 6 elasticsearch Vagrant setup with Puppet


A basic elasticsearch  install on top of a [@core CentOS6 Vagrant Box](http://vntx-box.s3.amazonaws.com/centos6.box).

Look at [bootstrap.pp](http://github.com/phips/c6vagrant/blob/master/puppet/manifests/bootstrap.pp) to see what Puppet is doing to the base CentOS6 [box](http://docs.vagrantup.com/v2/virtualbox/boxes.html).

##Installation
1. Install [Vagrant](http://www.vagrantup.com/) (and VirtualBox)
2. Peruse the [excellent and enlightening documentation](http://docs.vagrantup.com/v2/getting-started/index.html)
3. Clone this repo and type `vagrant up` from the directory that this README.md file resides in.
4. Open http://localhost:9200/


