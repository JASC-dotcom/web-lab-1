#
# Copiar ficheros de configuración de apache2 que incluyen:
#
# - apache2.conf,
# - apolo.olimpo.test.conf
# - atenea.olimpo.test.conf
#

cp -v /vagrant/files/mercurio.olimpo.test/apache2.conf /etc/apache2/
cp -v /vagrant/files/mercurio.olimpo.test/apolo.olimpo.test.conf /etc/apache2/sites-available/

#
# Habilitar los servidores virtuales
#

a2ensite apolo.olimpo.test.conf

#
# Reiniciar el servicio
#

apache2ctl configtest
systemctl restart apache2