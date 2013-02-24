class sakai::subversion {
  package { 'subversion':
    ensure => present,
  }
  
  vcsrepo { "/vagrant/sakai-src":
    ensure   => present,
    provider => svn,
    source   => "https://source.sakaiproject.org/svn/sakai/tags/sakai-2.9.1-all/",
    require  => Package["subversion"],
  }
}