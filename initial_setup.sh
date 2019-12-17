# Must be run as root

# See MIGRATION for how to perform the initial setup (which should never be
# needed)

chcon -u staff_u -R /home/sampre_jvs/jbovlaste

mkdir /home/sampre_jvs/jbovlaste/database
chown -R sampre_jvs:sampre_jvs /home/sampre_jvs/jbovlaste/database
semanage fcontext -a -t container_file_t '/home/sampre_jvs/jbovlaste/database(/.*)?'
restorecon -Rv /home/sampre_jvs/jbovlaste/database

mkdir /home/sampre_jvs/jbovlaste/site
chown -R sampre_jvs:sampre_jvs /home/sampre_jvs/jbovlaste/site
semanage fcontext -a -t container_file_t '/home/sampre_jvs/jbovlaste/site(/.*)?'
restorecon -Rv /home/sampre_jvs/jbovlaste/site

mkdir /home/sampre_jvs/jbovlaste/src
chown -R sampre_jvs:sampre_jvs /home/sampre_jvs/jbovlaste/src
semanage fcontext -a -t container_file_t '/home/sampre_jvs/jbovlaste/src(/.*)?'
restorecon -Rv /home/sampre_jvs/jbovlaste/src
