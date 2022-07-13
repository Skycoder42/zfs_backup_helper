#!/bin/bash

case "$1" in
  list)
    for set in main main/sub1 main/sub2 main/sub2/sub2a main/sub2/sub2b; do
      echo "$set@zfs-auto-snap_daily-2022-07-01-0600"
      echo "$set@zfs-auto-snap_weekly-2022-07-01-0600"
      echo "$set@zfs-auto-snap_monthly-2022-07-01-0600"
      echo "$set@zfs-auto-snap_daily-2022-07-02-0600"
      echo "$set@zfs-auto-snap_weekly-2022-07-03-0600"
      echo "$set@zfs-auto-snap_daily-2022-07-03-0600"
      echo "$set@zfs-auto-snap_daily-2022-07-04-0600"
    done
  ;;
esac
