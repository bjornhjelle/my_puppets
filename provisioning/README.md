My puppets
==========

I use this repository to manage puppet manifest, classes and modules, etc for my own personal use

Fedora 20: 
----------
    sudo yum install git puppet
    git clone git://github.com/bjornhjelle/my_puppets
    cd my_puppets
    sudo puppet apply --modulepath provisioning/modules provisioning/manifests/fedora20.pp



Modules:
----------

puppet module install --force -i modules puppetlabs/postgresql 
Notice: Preparing to install into /home/bjorn/puppet/modules ...
Notice: Downloading from https://forge.puppetlabs.com ...
Notice: Installing -- do not interrupt ...
/home/bjorn/puppet/modules
└── puppetlabs-postgresql (v2.5.0)

$ sudo puppet module install --force -i modules smarchive/googlechrome
Notice: Preparing to install into /home/bjorn/my_puppets/modules ...
Notice: Downloading from https://forge.puppetlabs.com ...
Notice: Installing -- do not interrupt ...
/home/bjorn/my_puppets/modules
└── smarchive-googlechrome (v0.1.0)

$ git clone https://github.com/anl/puppet-chrome.git modules/google-chrome
Cloning into 'modules/google-chrome'...
remote: Counting objects: 69, done.
remote: Compressing objects: 100% (27/27), done.
remote: Total 69 (delta 28), reused 66 (delta 25)
Unpacking objects: 100% (69/69), done.
Checking connectivity... done

$ puppet module install -i modules puppetlabs/apt
Notice: Preparing to install into /home/bjorn/my_puppets/modules ...
Notice: Downloading from https://forge.puppetlabs.com ...
Notice: Installing -- do not interrupt ...
/home/bjorn/my_puppets/modules
└─┬ puppetlabs-apt (v1.4.0)
  └── puppetlabs-stdlib (v4.1.0)
