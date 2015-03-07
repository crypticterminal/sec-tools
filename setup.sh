#!/bin/bash
CONNECT="psql -h db -p 5432 -U postgres postgres"
MSFUSER=${MSFUSER:-postgres}
MSFPASS=${MSFPASS:-postgres}

USEREXIST="$( $CONNECT -tAc "SELECT 1 FROM pg_roles WHERE rolname='$MSFUSER'")"

if [[ ! $USEREXIST -eq 1 ]]; then
  $CONNECT -c "create role $MSFUSER login password '$MSFPASS'"
fi

DBEXIST="$( $CONNECT -l | grep msf)"
    
if [[ ! $DBEXIST ]]; then 
  $CONNECT -c "CREATE DATABASE msf OWNER $MSFUSER;"
fi

/metasploit-framework/msfconsole
