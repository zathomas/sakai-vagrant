class sakai::sakai_dev {
  file { '/vagrant':
    ensure => directory,
  }

  package { 'subversion':
    ensure => present,
  }

  package { 'vim':
    ensure => present,
  }
  
  file { "/root/.aptitude": 
    ensure => directory,
  }

  file { "/root/.aptitude/config":
    ensure  => file,
    content => 'APT::Install-Recommends "0";',
    require => File["/root/.aptitude"],
  }
  
  # we use aptitude for the provider because unlike the default provider (apt)
  # we can ask aptitude not to install the 'recommended' packages for maven,
  # which amounts to a couple hundred MiB of stuff we don't need.
  package { "maven":
    ensure   => present,
    provider => aptitude,
    require  => File["/root/.aptitude/config"],
  }

  file { "/etc/profile.d/maven.sh":
    ensure => file,
    owner  => "root",
    group  => "root",
    mode   => 644,
    source => 'puppet:///files/maven.sh'
  }
  
  file { "/home/vagrant/.m2":
    ensure => directory,
    owner  => "vagrant",
  }
  
  file { "/home/vagrant/.m2/settings.xml":
    ensure => file,
    owner  => "vagrant",
    source => 'puppet:///files/settings.xml',
    require => File["/home/vagrant/.m2"]
  }

  svnworkdir { sakai:
    repository => "https://source.sakaiproject.org/svn/sakai/tags/sakai-2.9.1-all",
    local_container => "/vagrant",
    local_name => "sakai-src",
  }
}