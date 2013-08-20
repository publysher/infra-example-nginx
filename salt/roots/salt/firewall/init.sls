ufw:
  pkg:
    - installed
  service:
    - running
    - require:
       - cmd.run: ufw-enable

# Enable
ufw-enable:
  cmd.run:
    - name: ufw enable
    - require:
      - pkg: ufw

# SSH
ufw-ssh:
  cmd.run:
    - name: ufw allow SSH
    - require:
      - pkg: ufw
    - watch_in:
      - service: ufw
