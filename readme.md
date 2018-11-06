# Wordpress Dev - Centos7   

The purpose of this project is to have a consistent environemnt to develop a Wordpress site. If you are starting with Wordpress this will help you to get up and running quickly.

The project uses Vagrant with a basic shell script to install Ansible. After Ansible is installed, the main chunk of the Wordpress server is installed and configured by the following 5 roles:  
1. [base](blob/master/shared/ansible/roles/base/)
2. [mariadb](https://github.com/bertvv/ansible-role-mariadb/) --> Thanks to te creators of [ansible-role-mariadb](https://github.com/bertvv/ansible-role-mariadb/) as this role was heavily based on it with just some small modifications.
3. [nginx](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/roles/nginx/)
4. [php7](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/roles/php7/)
5. [wordpress](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/roles/wordpress/)

## Getting Started
1. **Shell script customisation**   
The [provisioning script](https://github.com/danielmacuare/Centos7_WP/blob/master/provisioning.sh) installs some base packages and repos like:  
- Python3.6  
- Virtualenv  
- Ansible (I'm currently using ANSIBLE_TAG="v2.7.0")  

2. **Ansible customisation**    
You can customise your server by simply editing the [Defaults var](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml)


### Prerequisites

[Vagrant](https://www.vagrantup.com/downloads.html)  
[Virtualbox](https://www.virtualbox.org/wiki/Downloads)  


### Installing
1. Clone the repo
```
git clone https://github.com/daniel280187/Centos7_WP.git

```

2. (Optional) - Modify your Vagrantfile. The file exposes 8080 on your host an redirects all requests on this port to port 80 in the guest host.

3. Create a vault file to securely store your [mariadb credentials](https://github.com/danielmacuare/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/mariadb_credentials.yaml)  
   Example: 
```
ansible-vault create group_vars/localhost/mariadb_credentials.yaml 
```

```yaml
---
vault_mariadb_web_username_pass: 123
vault_mariadb_root_pass: 123
```

4. Generate a strong password hash for the web_username. This is going to be the user you will use to run your wordpress server.
```
pip3.6 install passlib
python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"
Password:
$6$DQVUMUtOcuMiWRQA$/IYkXB3UqMKgJn2gXW6OuZqiN7BjrQ.48KDRzSfCEf1z1jS5suYYOayX7Twu/ybQB1Zwnagacf2Ps2/pQmeOl0
```

5. Then assign the value of the last line to your `web_username_pass_hash` variable at [Default_vars](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml)
```
auth_key_dir: "/etc/ssh/authorized_keys"
web_username_pass_hash: '$6$DQVUMUtOcuMiWRQA$/IYkXB3UqMKgJn2gXW6OuZqiN7BjrQ.48KDRzSfCEf1z1jS5suYYOayX7Twu/ybQB1Zwnagacf2Ps2/pQmeOl0'
```

6. Create a sudo user to manage your server. For security, you will only be able to access the server by using SSH keys, not passwords, so let's generate a pair of keys:  
**Important: The name of the key and the username must match, so if your sudo user is going to be called "wordpress_dev", then create keys with the same name**

```bash
ssh-keygen -f wordpress_dev -C "User to manage your Wordpress site"
```

7. Add the sudo user's public key in the [base/files](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/roles/base/files/) dir. In this example we will add /base/files/**wordpress_dev.pub**

8. Edit the [Defaults var](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml)  "user.username" and "user.ssh_pub_key" vars to tell the base role where to look for the users's public key. Again, notice that the username **'wordpress'** and the name of the public key **'wordpress_dev.pub'** must match because Ansible will then move that key to **auth_key_dir: "/etc/ssh/authorized_keys"** based on that match.

```yaml
# BASE ROLE
auth_key_dir: "/etc/ssh/authorized_keys"
web_username_pass_hash: '$6$DQVUMUtOcuMiWRQA$/IYkXB3UqMKgJn2gXW6OuZqiN7BjrQ.48KDRzSfCEf1z1jS5suYYOayX7Twu/ybQB1Zwnagacf2Ps2/pQmeOl0'

users:
  - username: wordpress_dev
    use_sudo: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'wordpress_dev.pub' ) }}"
  - username: vagrant
```

9. To finish the setup, just:
`vagrant up`


**And have fun creating your Wordpress site!!!**


## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **Daniel Macuare** - *Initial work* - [Daniel Macuare](https://github.com/danielmacuare)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to the team who developed the [ansible-role-mariadb](https://github.com/bertvv/ansible-role-mariadb/) as it was barely modified to customise it to this project.
