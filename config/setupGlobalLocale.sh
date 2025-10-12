grep -q "LC_TIME=de_DE.UTF-8" /etc/locale.conf
if [ $? -ne 0 ]; then
  echo LC_TIME=de_DE.UTF-8 >> /etc/locale.conf
elif [ "$?" -eq 1 ]; then
  sed -i 's/LC_TIME=.*/LC_TIME=de_DE.UTF-8/' /etc/locale.conf
fi
