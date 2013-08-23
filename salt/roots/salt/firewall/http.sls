ufw-nginx:
  ufw.allowed:
    - protocol: tcp
    - port: http,https
    - require:
      - pkg: ufw
