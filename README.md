# CentOS 7, RHEL 7 初期設定(Initial Setting)


Install ansible
---------------

```ruby:install ansible
yum install ansible -y
```


Enable sudo_flags
-----------------

/etc/ansible/ansible.cfg の sudo_flags の コメントを外してください。
Please uncomment ansible.cfg's sudo_flags.

```ruby:change ansible.cfg
sudo_flags = -H -S -n
```

Example Hosts
-------------

```
# localhostの場合(In case of localhost)
cat << EOF > localhost
[servers]
localhost ansible_connection=local
EOF

# ステージング環境の場合(In case of staging environment)
cat << EOF > staging
[servers]
HostName or IP
HostName or IP

[all:vars]
ansible_ssh_user=ec2-user
EOF

# 本番環境の場合(In case of production environment)
cat << EOF > production
[servers]
HostName or IP
HostName or IP

[all:vars]
ansible_ssh_user=ec2-user
EOF
```


Change group_vars
-----------------

```ruby:定数設定(Constant setting)
#-----------
# 変数設定(vars)
#-----------

#Proxy URL
proxy_host: proxy.xxxxxxxxx.co.jp
proxy_port: port_no

http_proxy: "http://{{ proxy_host }}:{{ proxy_port }}/"

#No Proxy
no_proxys: xxxxx.co.jp,yyyy.co.jp

#社内CA証明書 URL(Internal Certification Authority URL)
ca_url: https://xxxxxxxx.co.jp/xxx.ca
ca_sha256: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx(*1)
```

*1. xxx.ca の ca_sha256 の 値は sha256sum コマンドで確認してください。
    Please check the value of xxx.ca's ca_sha256 with the sha256sum command.

```
sha256sum xxx.ca
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx(Hash Value)
```


Comment out when there is no Internal CA
----------------------------------------

```ruby:change site.yml
- hosts: servers
  sudo: yes
  roles:
  - init
#  - ca
  post_tasks:
  - name: 完了
    debug: msg='Setup is completed.'
```


Execute Playbook
-----------------

実行例(Normal execution)

```
# ローカルの場合(In case of localhost)
ansible-playbook -i localhost site.yml --private-key=/path/key.pem

# ステージング環境の場合(In case of staging environment)
ansible-playbook -i staging site.yml --private-key=/path/key.pem

# 本番環境の場合(In case of production environment)
ansible-playbook -i production site.yml --private-key=/path/key.pem
```

デバッグ実行例(Debug execution)

```
# ローカルの場合(In case of localhost)
ansible-playbook -i localhost site.yml --private-key=/path/key.pem -vvv

# ステージング環境の場合(In case of staging environment)
ansible-playbook -i staging site.yml --private-key=/path/key.pem -vvv

# 本番環境の場合(In case of production environment)
ansible-playbook -i production site.yml --private-key=/path/key.pem -vvv
```


License
-------

[Apache License Version 2.0](https://github.com/kouji-kojima/sample-ansible-el7/blob/master/LICENSE)


Author Information
------------------

Kouji Kojima
