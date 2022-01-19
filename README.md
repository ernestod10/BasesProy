# BasesProy






Para el Error:
ORA-65096: invalid common user or role name
65096. 00000 -  "invalid common user or role name"

ORA-28014: cannot drop administrative user or role
28014. 00000 -  "cannot drop administrative user or role"

Solucion:
alter session set "_ORACLE_SCRIPT"=true;