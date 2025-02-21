#!/bin/bash
/bin/irule -r irods_rule_engine_plugin-irods_rule_language-instance \
      -F /var/lib/irods/.irods/job_movetovault.r \
      >>$HOME/iRODS/server/log/job_movetovault.log 2>&1

# Check if the job is still running. This can happen if the previous
# job hasn't finished before this one started. In this case, the previous
# job will clear the locks when it's finished, so this job should
# leave the locks in place.
if pgrep -u irods -f /var/lib/irods/.irods/job_movetovault.r >& /dev/null
then echo "job_movetovault still running; not clearing locks ..."
else /bin/irule -r irods_rule_engine_plugin-irods_rule_language-instance \
          -F /var/lib/irods/.irods/job_clearintakelocks.r 2>&1
fi
