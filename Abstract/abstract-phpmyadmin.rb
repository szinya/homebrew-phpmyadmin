require 'formula'

class AbstractPhpmyadmin < Formula
  homepage 'http://www.phpmyadmin.net'
  head 'https://github.com/phpmyadmin/phpmyadmin.git'

  if build.with? 'mcrypt'
    depends_on "php53-mcrypt" if Formula['php53'].linked_keg.exist?
    depends_on "php54-mcrypt" if Formula['php54'].linked_keg.exist?
    depends_on "php55-mcrypt" if Formula['php55'].linked_keg.exist?
    depends_on "php56-mcrypt" if Formula['php56'].linked_keg.exist?
  end

  unless MacOS.prefer_64_bit?
    option 'without-mcrypt', "Exclude the php-mcrypt module"
  end

  def install
    (share+'phpmyadmin').install Dir['*']
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install mysql. It is not
    required since you might want to get connected to a remote
    database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phpmyadmin #{HOMEBREW_PREFIX}/share/phpmyadmin
      <Directory #{HOMEBREW_PREFIX}/share/phpmyadmin/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
      </Directory>
    Then, open http://localhost/phpmyadmin

    More documentation : file://#{share}/phpmyadmin/doc/

    Don't forget to copy config.sample.inc.php to config.inc.php and :
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end
end
