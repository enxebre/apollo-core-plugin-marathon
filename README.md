Marathon Apollo Plugin
======================

[![wercker status](https://app.wercker.com/status/139e779b40ee1492b5a28f28a14dc21c/m "wercker status")](https://app.wercker.com/project/bykey/139e779b40ee1492b5a28f28a14dc21c)

Apollo is a plugin based system.

## Running the tests

Requirements:

* [Ansible >= 1.9.0.1](http://www.ansible.com/home)
* [Ansible-lint](https://github.com/willthames/ansible-lint)
* [Serverspecs >= 2.17.0](serverspec.org)
* [Vagrant](https://www.vagrantup.com/) For applying the role and running the serverspecs. 

For running the quality checks and serverspecs just run:

```bash
# Spin up a vm from "capgemini/apollo" and provision it with ansible role
Vagrant up

# Show all available tasks
rake -T --all

# Run them all
rake
```

For more info about how to develop and contribute Apollo Plugins see [Apollo Contributing guide.](https://github.com/Capgemini/Apollo/blob/master/CONTRIBUTING.md)
