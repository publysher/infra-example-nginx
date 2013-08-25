unattended-upgrades:
  pkg:
    - latest
  service:
    - running
    - require:
      - pkg: unattended-upgrades


Enable unattended upgrades:
  file.managed:
    - name: /etc/apt/apt.conf.d/02periodic
    - source: salt://auto_update/02periodic
    - user: root
    - group: root
    - mode: 644
