ufw-http:
  ufw.allowed:
    - protocol: tcp
    - to_port: http
    - require:
      - pkg: ufw

ufw-https:
  ufw.allowed:
    - protocol: tcp
    - to_port: https
    - require:
      - pkg: ufw
