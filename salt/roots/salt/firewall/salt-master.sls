include:
  - firewall.base

{% for minion in pillar['minions'] %}

ufw-salt-master-{{ minion }}:
  ufw.allowed:
    - from_addr: {{ minion }}
    - protocol: tcp
    - to_port: "4505,4506"
    - require:
      - pkg: ufw

{% endfor %}
