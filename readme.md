# Wordpress Dev - Centos7   (Readme in Progress)

The purpose of this project is to have a consistent environemnt to develop a Wordpress site. If you are starting with Wordpress this will help you to get up and running quickly.

The project uses Vagrant with a basic shell script to install Ansible.After Ansible is installed, the main chunk of the Wordpress server is installed and configured by the following 5 roles:  
1. [base](blob/master/shared/ansible/roles/base/)
2. [mariadb](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/roles/base/)
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

- To add users to the server:  
Add its public key here user's public keys in the [base/files](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/roles/base/files/). In this example we will add /base/files/**example.pub**

   Edit the [Defaults var](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/group_vars/localhost/defaults.yaml) file to tell the base role where to look for the users's public key. Notice that the username and the name of the public key must match because Ansible will then move that key to **auth_key_dir: "/etc/ssh/authorized_keys"**

```yaml
# BASE ROLE
auth_key_dir: "/etc/ssh/authorized_keys"

users:
  - username: example
    use_sudo: true
    ssh_access: true
    ssh_pub_key: "{{ lookup('file', 'example.pub' ) }}"
  - username: vagrant
```


### Prerequisites



```
[Vagrant](https://www.vagrantup.com/downloads.html)
[Virtualbox](https://www.virtualbox.org/wiki/Downloads)
```

### Installing



```
git clone https://github.com/daniel280187/Centos7_WP.git
If you are going to add ssh keys for an user:
    Put your Public key in shared/ansible/roles/base/files
    SSH Keys will be added to the 'auth_key_dir' defined in shared/ansible/roles/base/vars/main.yaml
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With



* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
