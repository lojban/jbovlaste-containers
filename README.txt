This is the containerized service infrastructure for jbovlaste.

This is an LBCS instance (see https://github.com/lojban/lbcs/ ), which is why a
bunch of things in here are symlinks off into apparently empty space; you have
to have LBCS installed in /opt/lbcs/ for them to work.

That's also where the docs on how to like start and stop the service and so on
are.

Deploying A Fresh Instance
==========================

Assuming you have rootless podman working, you should be able to deploy a copy
of jbovlaste with something like this:

As yourself or root or whatever:

$ cd /opt
$ git clone git@github.com:lojban/lbcs.git

As the system account you're using for the service:

$ cd ~
$ git clone git@github.com:lojban/jbovlaste-containers.git jbovlaste/
$ cd ~/jbovlaste/containers/web
$ git clone https://github.com/lojban/jbovlaste src/
$ cd ~/jbovlaste/containers/jiten
$ git clone https://github.com/lojban/jiten src/

You'll then need to copy or restore the database backup into ~/jbovlaste/containers/db/data/

$ cd ~/jbovlaste
$ ./setup.sh

At that point systemctl commands should work as expected, although you'll probably want to test with:

$ ./run_container.sh db
$ ./run_container.sh web
$ ./run_container.sh jiten
