#!/bin/bash
PAGE_LOCATION=nginx
if [ $1 = "on" ] && [ -f $PAGE_LOCATION/maintenance_off.html ]; then
  mv $PAGE_LOCATION/maintenance_off.html $PAGE_LOCATION/maintenance_on.html;
elif [ $1 = "off" ] && [ -f $PAGE_LOCATION/maintenance_on.html ]; then
  mv $PAGE_LOCATION/maintenance_on.html $PAGE_LOCATION/maintenance_off.html;
else
  echo "nothing was changed";
fi
