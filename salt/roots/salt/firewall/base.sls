fail2ban:
  pkg:
    - latest

ufw:
  pkg:
    - installed
  ufw.enabled:
    - require:
      - pkg: ufw


ufw-ssh:
  ufw.allowed:
    - protocol: tcp
    - to_port: ssh
    - require:
      - pkg: ufw

