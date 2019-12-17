#!/bin/bash
user=$1
pass=$2
uid=$(getent passwd | awk -F : '{print $3}' | sort -n |tail -n 2 | head -1)
uid=$((uid+1))

echo "$uid"


password=$(slappasswd -s 123)
echo "$password"


cp ldapuser.ldif ldapuser1.ldif
sed -i "s/amit/${user}/g" ldapuser1.ldif
sed -i "s/{SSHA}p18K5liYx1bdL93SrjztHGApyi3wTkc4/${password}/g" ldapuser1.ldif
sed -i "s/1000/${uid}/g" ldapuser1.ldif

cat ldapuser1.ldif

ldapadd -x -w 123 -D "cn=admin,dc=tbs,dc=com" -f ldapuser1.ldif


