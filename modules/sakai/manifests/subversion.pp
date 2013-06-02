class sakai::subversion {
  package { 'subversion':
    ensure => present,
  }
  
  vcsrepo { "/vagrant/sakai-src":
    ensure   => present,
    provider => svn,
    source   => "https://source.sakaiproject.org/svn/sakai/trunk",
    require  => Package["subversion"],
  }
}
