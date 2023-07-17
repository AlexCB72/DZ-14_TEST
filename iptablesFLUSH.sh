#!/bin/bash

# Очищаем правила
iptables -F
iptables -F -t nat
iptables -F -t mangle
iptables -X
iptables -t nat -X
iptables -t mangle -X

# Разрешаем все
iptables -P INPUT ACCEPT 
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# Сохраняем правила
 /sbin/iptables-save  > /etc/sysconfig/iptables
