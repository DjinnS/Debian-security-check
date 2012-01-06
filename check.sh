#!/bin/sh
#
# check.sh
#
# The simplest way to check if packages must be updated from Debian security repository 
#
# http://github.com/djinns/Debian-security-check
#
# Copyright (C) 2012 djinns@chninkel.net
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

# must be changed !
DSTMAIL="djinns@chninkel.net"

apt-get update > /dev/null

toupdate=`apt-get --just-print -V dist-upgrade | grep -i security | grep -i "inst" | cut -d " " -f2 | tr "\n" "%"`

if [ "x${toupdate}" != "x" ]; then

		content=`mktemp`
        echo -e "\nThe following package must be update:\n" >> ${content}
        echo ${toupdate} | tr "%" "\n" >> ${content}

		cat ${content} | mail -s "Debian security check - report for `hostname`" ${DSTMAIL}

		rm ${content}
fi

