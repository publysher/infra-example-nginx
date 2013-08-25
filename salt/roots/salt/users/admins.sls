publysher:
  user.present:
    - shell: /bin/bash

  ssh_auth.present:
    - user: publysher
    - source: salt://users/files/publysher.pub
    - require:
      - user: publysher

  file.managed:
    - name: /etc/sudoers.d/publysher
    - source: salt://users/files/admin.sudo
    - template: jinja
    - context:
        username: publysher
    - require:
      - user: publysher
