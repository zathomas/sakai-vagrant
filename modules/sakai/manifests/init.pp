class sakai {
  define download_file(
    $site="",
    $cwd="",
    $creates="",
    $user="",
    $timeout="300") {

      exec { $name:
        command => "/usr/bin/wget ${site}/${name}",
        cwd     => $cwd,
        creates => "${cwd}/${name}",
        user    => $user,
        timeout => $timeout,
      }
  }

  define svnworkdir($repository, $local_container, $local_name = false, $svn_username = false, $svn_password = false)
  {
    $owner_real = $owner ? { false => 0, default => $owner }
    $group_real = $group ? { false => 0, default => $group }
    $local_name_real = $local_name ? { false => $name, default => $local_name }
    Exec {
      path => "/usr/bin:/bin:/opt/local/bin:/usr/local/bin" }
      $retrieve_command = $svn_username ? {
        false   => "svn checkout --non-interactive '$repository' '$local_name_real'",
        default => "svn checkout --non-interactive --username='$svn_username' --password='$svn_password' '$repository' '$local_name_real'"
      }
    exec { "svn-co-$name":
      command => $retrieve_command,
      cwd => $local_container,
      require => [ File["$local_container"], Package["subversion"]],
      creates => "$local_container/$local_name_real/.svn",
      timeout => "0",
    }
  }
}