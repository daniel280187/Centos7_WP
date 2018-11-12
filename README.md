# Wordpress Dev - Centos7 (Vagrant + Shell + Ansible) (Work In Progress)

The purpose of this project is to have a consistent environemnt to develop a Wordpress site. If you are starting with Wordpress this will help you to get up and running quickly.

The project uses Vagrant with a basic shell script to install Ansible. After Ansible is installed, the main chunk of the Wordpress server is installed and configured by the following 5 roles:  
1. [base](shared/ansible/roles/base/)
2. [mariadb](https://github.com/bertvv/ansible-role-mariadb/) --> Thanks to te creators of [ansible-role-mariadb](https://github.com/bertvv/ansible-role-mariadb/) as this role was heavily based on it with just some small modifications.
3. [nginx](shared/ansible/roles/nginx/)
4. [php7](shared/ansible/roles/php7/)
5. [wordpress](shared/ansible/roles/wordpress/)

**For more information you can see a mind map [here](shared/ansible/Wordpress_ansible.pdf) with information about the provisioning process.**

## Getting Started
1. **Shell script customisation**   
The [provisioning script](https://github.com/danielmacuare/Centos7_WP/blob/master/provisioning.sh) installs some base packages and repos like:  
- Python3.6  
- Virtualenv  
- Ansible (I'm currently using ANSIBLE_TAG="v2.7.0")  

2. **Ansible customisation**    
You can customise your server by simply editing the [Defaults var](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml)


### Prerequisites

- [Vagrant](https://www.vagrantup.com/downloads.html)  
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)  


### Installing
1. Clone the repo
```
git clone https://github.com/daniel280187/Centos7_WP.git
```
2. Generate a strong password hash for the web_username. This is going to be the account you will use to run your wordpress server.
```
pip3.6 install passlib
python -c "from passlib.hash import sha512_crypt; import getpass; print(sha512_crypt.using(rounds=5000).hash(getpass.getpass()))"
Password:
$6$DQVUMUtOcuMiWRQA$/IYkXB3UqMKgJn2gXW6OuZqiN7BjrQ.48KDRzSfCEf1z1jS5suYYOayX7Twu/ybQB1Zwnagacf2Ps2/pQmeOl0
```

3. Then assign the value of the last line to your `web_username_pass_hash` variable at [Default_vars](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml)
```
auth_key_dir: "/etc/ssh/authorized_keys"
web_username_pass_hash: '$6$DQVUMUtOcuMiWRQA$/IYkXB3UqMKgJn2gXW6OuZqiN7BjrQ.48KDRzSfCEf1z1jS5suYYOayX7Twu/ybQB1Zwnagacf2Ps2/pQmeOl0'
```

4. Create a sudo user to manage your server. For security, you will only be able to access the server by using SSH keys, not passwords, so let's generate a pair of keys:  
**Important: The name of the key and the username must match, so if your sudo user is going to be called "wordpress_dev", then create keys with the same name**  

```bash
ssh-keygen -f  ~/.ssh/wordpress_dev -C "User's key to manage my Wordpress site"

cp ~/.ssh/wordpress_dev.pub shared/ansible/roles/base/files
```

5. Edit the [Defaults var](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml)  "user.username" and "user.ssh_pub_key" vars to tell the base role where to look for the users's public key. Again, notice that the username **'wordpress'** and the name of the public key **'wordpress_dev.pub'** must match because Ansible will then move that key to **auth_key_dir: "/etc/ssh/authorized_keys"** based on that match.

```yaml
vim shared/ansible/group_vars/localhost/defaults.yaml

# BASE ROLE
auth_key_dir: "/etc/ssh/authorized_keys"
web_username_pass_hash: '$6$DQVUMUtOcuMiWRQA$/IYkXB3UqMKgJn2gXW6OuZqiN7BjrQ.48KDRzSfCEf1z1jS5suYYOayX7Twu/ybQB1Zwnagacf2Ps2/pQmeOl0'

users:
  - username: wordpress_dev
    use_sudo: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'wordpress_dev.pub' ) }}"
```

6. (Optional) - Modify your [Vagrantfile](Vagrantfile). The file exposes the port 8080 on your host an redirects all requests on this port to port 80 in the guest host.


7. (Optional) Create a new .vault_pass file at shared/ansible/.vault_pass. This password will be used to encrypt/decrypt the files that we instantiate with ansible-vault. Additionally, Ansible will use this file to decrypt it's secrets and read the file in point 4. So imagine, you want to make your password 'blogpass' (I encourage you to use strong passwords instead)  

```
echo blogpass > shared/ansible/.vault_pass
```

8. (Optional) Create a vault file to securely store your [mariadb credentials](https://github.com/danielmacuare/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/mariadb_credentials.yaml)  
   Example: 
```
ansible-vault create shared/ansible/group_vars/localhost/mariadb_credentials.yaml 
```

Default values if you want to leave it like this:  
```yaml
---
vault_mariadb_web_username_pass: 123
vault_mariadb_root_pass: 123
```

9. To finish the setup, just:  
`vagrant up`

**And have fun creating your Wordpress site!!!**


## Authors

* **Daniel Macuare** - *Initial work* - [Daniel Macuare](https://github.com/danielmacuare)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thanks to the team who developed the [ansible-role-mariadb](https://github.com/bertvv/ansible-role-mariadb/) as it was barely modified to customise it to this project.
