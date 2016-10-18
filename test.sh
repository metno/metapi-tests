#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# metapi
#
# Copyright (C) 2016 met.no
#
#  Contact information:
#  Norwegian Meteorological Institute
#  Box 43 Blindern
#  0313 OSLO
#  NORWAY
#  E-mail: metapi@met.no
#
#  This is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

SCRIPT_VERSION="0.1"

SCRIPT_USAGE="Usage: $0 <Options>

This script runs acceptance tests against a METAPI server.

Options:
--help             display this help and exit
--version          output version information and exit
--id=CLIENT-ID     the client ID to use for the tests.
--url=METAPI-URL   the URL to run the tests against. This defaults to
      https://staging-data.met.no
"

CLIENT_ID=""
METAPI_URL="https://staging-data.met.no"

# Parse command line
while test -n "$1"; do
  case "$1" in
  --help)
    echo "$SCRIPT_USAGE"; exit 0;;
  --version)
    echo "$0 $SCRIPT_VERSION"; exit 0;;
  --id=*)
    CLIENT_ID=`echo $1 | sed 's/--id=//'`
    shift
    continue;;
  --URL=*)
    METAPI_URL=`echo $1 | sed 's/--url=//'`
    shift
    continue;;
  esac
done

METAPIBASE=$METAPI_URL CLIENTID=$CLIENT_ID activator test
