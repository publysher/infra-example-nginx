{% for username in pillar['users']['admins'] %}

{{ username }}:
  user.present:
    - shell: /bin/bash

  ssh_auth.present:
    - user: {{ username }}
    - source: salt://users/files/{{ username }}.pub
    - require:
      - user: {{ username }}

  file.managed:
    - name: /etc/sudoers.d/{{ username }}
    - source: salt://users/files/admin.sudo
    - template: jinja
    - context:
        username: {{ username }}
    - require:
      - user: {{ username }}

{% endfor %}


{% for username in pillar['users']['banned'] %}
{{ username }}:
  user.absent:
    - purge: True
    - force: True
{% endfor %}
