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

  download_file { "apache-maven-3.0.4-bin.tar.gz":
    site => "http://mirrors.ibiblio.org/apache/maven/maven-3/3.0.4/binaries",
    cwd => "/home/vagrant",
    creates => "/home/vagrant/$name",
    user => "vagrant",
  }

  exec { '/bin/tar xzf /home/vagrant/apache-maven-3.0.4-bin.tar.gz':
    unless => '/usr/bin/test -d /home/vagrant/apache-maven-3.0.4',
    cwd    => '/home/vagrant',
    user   => "vagrant",
    require => Download_file["apache-maven-3.0.4-bin.tar.gz"],
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