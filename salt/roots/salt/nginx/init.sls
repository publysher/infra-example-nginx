nginx:
  pkg:
    - latest
  service.running:
    - watch:
      - file: nginx-vhost-default
      - file: nginx-vhost-default-enabled


nginx-vhost-default:
  file.managed:
    - name: /etc/nginx/sites-available/default
    - source: salt://nginx/vhosts/default.nginx
    - require:
      - pkg: nginx

nginx-vhost-default-enabled:
  file.symlink:
    - name: /etc/nginx/sites-enabled/default
    - target: /etc/nginx/sites-available/default
    - require:
      - pkg: nginx


/var/www/default/index.html:
  file.managed:
    - source: salt://nginx/www/index.html

/var/www/default/404.html:
  file.managed:
    - source: salt://nginx/www/404.html
