ufw-salt-master:
  ufw.allowed:
    - from_addr: nginx01.intranet
    - protocol: tcp
    - to_port: "4505,4506"
    - require:
      - pkg: ufw
