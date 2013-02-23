DNS Switcher
============

Quickly switch between DNS profiles

(currently only supports Mac)

```bash
npm install -g dns-switcher
```

to add zsh completions:

```bash
dns --completions >> ~/.zshrc
```

**NOTE:** If you're using the completions and you get a warning about insecure directories
it's because the owner of the directory ".../node/.../lib/node_modules/dns/completions"
should be either the root user or the current user.


Configuration
==============

Create a file named '.dns.coffee' in your home directory:

```coffee
module.exports =
  profile1:
    nameservers: [ '1.2.3.4', '5.6.7.8' ]
  profile2:
    nameservers: [ '7.8.9.10' ]
    search_domains: [ 'domain1', 'domain2' ]
```

Usage
======

```bash
# show the names of the profiles specified in ~/.tailr.coffee
dns --list
dns -l

# load a profile
dns profile1

# reset the dns settings
dns --reset
dns -r

# show the current dns settings
dns

# By default, it uses the "Wi-Fi" device,
# you can specifiy a different device like this:
dns -d Ethernet1 profile1

```
