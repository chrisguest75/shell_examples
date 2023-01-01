# syntax=docker/dockerfile:1.4
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -fy -qq watchman \
    && apt-get clean 

WORKDIR /scratch
COPY --chmod=755 <<EOF /scratch/triggered.sh
#!/usr/bin/env bash
echo "Triggering..."
echo "$@"
env 
while IFS=, read line; do
    echo "$line"
    # do something with the file
done
echo "Exiting..."
EOF


COPY --chmod=755 <<EOF /scratch/watch.sh
#!/usr/bin/env bash
echo "/proc/sys/fs/inotify/max_user_instances impacts how many different root dirs you can watch."
echo "/proc/sys/fs/inotify/max_user_watches impacts how many dirs you can watch across all watched roots."
echo "/proc/sys/fs/inotify/max_queued_events impacts how likely it is that your system will experience a notification overflow."
echo "max_user_instances: $(cat /proc/sys/fs/inotify/max_user_instances)"
echo "max_user_watches: $(cat /proc/sys/fs/inotify/max_user_watches)"
echo "max_queued_events: $(cat /proc/sys/fs/inotify/max_queued_events)"
watchman --version 
#watchman --log-level 2 --persistent --statefile=/scratch/watcher.state --logfile=/scratch/watcher.log watch "\$1"
watchman --log-level 2 --persistent --statefile=/scratch/watcher.state --logfile=/scratch/watcher.log -- trigger /share sharefolder '*.txt' -- /scratch/triggered.sh
#watchman-wait watch "\$1"
#watchman -- trigger "\$1" all -- /bin/true
#ps -a
while true; do
    sleep infinity
done
EOF

ENTRYPOINT ["/scratch/watch.sh", "/share" ]

