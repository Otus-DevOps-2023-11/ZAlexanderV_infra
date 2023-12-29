# ДЗ 3 Развёртывание Облачного приложения
В данном ДЗ реализовано
 - Установка компонентов ОС
 - Развёртывание приложения и его зависимостей
 - Автоматизиция процесса развёртывания ОС, приложения и зависимостей
 - Интеграция скриптов в user metadata для автоматического развёртывания

1. Комманда для развёртывания instance
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --zone ru-central1-a \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/yc_key_pub \
  --folder-id b1gs4m14eth4n4rjck3k
```

2. Для автоматизации процесса необходимо использовать комманду
```
 yc compute instance create \
 --name reddit-app \
 --hostname reddit-app \
 --memory=4 \
 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
 --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
 --zone ru-central1-a \
 --metadata serial-port-enable=1 \
 --metadata-from-file user-data=cloud_config_v1.yaml \
 --folder-id b1gs4m14eth4n4rjck3k

```

testapp_IP = 158.160.34.17
testapp_port = 9292
