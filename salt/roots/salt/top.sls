base:
  '*':
    - firewall.base
    - sshd_config
    - auto_update
    - users.admins

  'salt.intranet':
    - firewall.salt-master

  'nginx01.intranet':
    - firewall.http
    - nginx
