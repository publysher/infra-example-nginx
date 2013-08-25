base:
  '*':
    - sshd_config
    - firewall
    - auto_update
    - users.admins

  'salt.intranet':
    - firewall.salt-master

  'nginx01.intranet':
    - nginx
    - firewall.http
