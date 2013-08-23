ssh:
  service.running

Disable root login:
  augeas.value:
    - name: /files/etc/ssh/sshd_config/PermitRootLogin
    - value: "no"
    - watch_in:
      - service: ssh

Disable password authentication:
  augeas.value:
    - name: /files/etc/ssh/sshd_config/PasswordAuthentication
    - value: "no"
    - watch_in:
      - service: ssh


