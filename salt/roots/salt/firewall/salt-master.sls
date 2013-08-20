ufw-salt-master:
  cmd.run:
    - name: ufw allow from $(getent ahosts nginx01.intranet | awk 'NR==1 {print $1}') to any port 4505,4506 proto tcp
    - require:
      - pkg: ufw
    - watch_in:
      - service: ufw

