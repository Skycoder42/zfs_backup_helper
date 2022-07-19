#!/bin/bash

case "$1" in
  list)
    ROOT_DATASET=$8
    for set in $ROOT_DATASET $ROOT_DATASET/sub1 $ROOT_DATASET/sub2 $ROOT_DATASET/sub2/sub2a $ROOT_DATASET/sub2/sub2b; do
      echo "$set@zfs-auto-snap_daily-2022-07-01-0600"
      echo "$set@zfs-auto-snap_weekly-2022-07-01-0600"
      echo "$set@zfs-auto-snap_monthly-2022-07-01-0600"
      echo "$set@zfs-auto-snap_daily-2022-07-02-0600"
      echo "$set@zfs-auto-snap_weekly-2022-07-03-0600"
      echo "$set@zfs-auto-snap_daily-2022-07-03-0600"
      echo "$set@zfs-auto-snap_daily-2022-07-04-0600"
    done
    echo "$ROOT_DATASET/sub2@zfs-auto-snap_daily-2022-06-30-0600"
    ;;
  send)
    echo "BINARY DATA FOR: $@"
    ;;
  *)
    exit 127
    ;;
esac
