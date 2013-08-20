ufw-nginx:
  cmd.run:
    - name: ufw allow 'WWW Full'
    - require:
      - pkg: ufw
    - watch_in:
      - service: ufw
