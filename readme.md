# Wordpress Dev - Centos7   (Readme in Progress)

The purpose of this project is to have a consistent environemnt to develop a wordpress site. If you are starting with Wordpress this will help you to get up and running quickly.

The project uses Ansible to provision the server and you can customise the YUM packages you want to add to the box by simply editing the [Host vars](https://github.com/daniel280187/Centos7_WP/blob/master/shared/ansible/host_vars/127.0.0.1.yaml)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

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
