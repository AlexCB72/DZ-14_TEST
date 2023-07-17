# для host-23
# блокируем весь входящий траффик, кроме ssh, icmp, запросов с host-21,22 и ответов туда же по портам 8081, 8082, 8083.

# Очищаем правила
iptables -F
iptables -F -t nat
iptables -F -t mangle
iptables -X
iptables -t nat -X
iptables -t mangle -X

# Рзрешаем пинги
iptables -A INPUT -p icmp -j ACCEPT

# разрешаем установленные подключения
iptables -A INPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p all -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p all -m state --state ESTABLISHED,RELATED -j ACCEPT

# открываем доступ к SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Разрешаем localhost и указанные адреса для apache
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -s 192.168.1.21 -p tcp --dport 8081 -j ACCEPT
iptables -A INPUT -s 192.168.1.21 -p tcp --dport 8082 -j ACCEPT
iptables -A INPUT -s 192.168.1.21 -p tcp --dport 8083 -j ACCEPT
iptables -A INPUT -s 192.168.1.22 -p tcp --dport 8081 -j ACCEPT
iptables -A INPUT -s 192.168.1.22 -p tcp --dport 8082 -j ACCEPT
iptables -A INPUT -s 192.168.1.22 -p tcp --dport 8083 -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Запрещаем все, что не разрешено
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP


# Сохраняем правила
 /sbin/iptables-save  > /etc/sysconfig/iptables
