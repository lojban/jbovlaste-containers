Managing Normally
=================

This setup is managed by sytemd over rootless podman, but the podman part
shouldn't normally be relevant, so here's some command examples to perform
basic operations:

$ systemctl --user status
# This will start both because dependencies:
$ systemctl --user start jbovlaste_site
$ systemctl --user restart jbovlaste_site
$ systemctl --user stop jbovlaste_site
# Some logs:
$ systemctl --user status jbovlaste_database
# More logs:
$ journalctl --user -t jbovlaste_database
$ journalctl --user
# Watch live logs:
$ journalctl -f --user

Managing Manually
=================

To Launch
---------

$ ./run_database.sh
$ ./run_site.sh

To Shut Down
------------

$ ./kill_site.sh
$ ./kill_database.sh

NB: THIS DESTROYS ALL LIVE STATE.  If you need logs or something, do just the
"kill"s and not the "rm"s from that script.

The Containers
--------------

Both the site and the database run inside containers; you can see them with
"podman ps -a".  If you're like "what the hell is podman?", just pretend it's
docker and you should be fine.  If you're like "what the hell is docker?", you
shouldn't be trying to administer this.

Problems
--------

If things are behaving strangly you can try 

# sudo bash -x setup.sh

as a user with unconfined sudo.

The Database
============

The new database lives on mariadb (née mysql) in database/

The Sites
=========

Live under site/ ; the httpd config is httpd_glaukaba.conf

There are a lot of symlinks; this is so we only have one copy of the code, so
that changes are usable everywhere.
