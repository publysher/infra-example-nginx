base:
  '*':
    - sshd_config
    - firewall
    - auto_update

  'salt.intranet':
    - firewall.salt-master

  'nginx01.intranet':
    - nginx
    - firewall.http
