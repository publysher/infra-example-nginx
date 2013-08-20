base:
  '*':
    - firewall

  'salt.intranet':
    - firewall.salt-master

  'nginx01.intranet':
    - nginx
    - firewall.http
