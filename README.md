# ZAlexanderV_infra
ZAlexanderV Infra repository

### ДЗ№2 
В рамках этого задания были выполнены задачи
 - развёртывание виртуальных машин в облаке Yandex
 - Настроен хост бастион
 - Подготовленна конфигурация для прямого подключения на внутренний хост
 - Настроен Pritun 
 - Выпущен сертификат для Pritun(не совсем выпущен)

#Yandex Cloud
Подключение ко внутрненним хостам доступно через следующие приёмы:
 - Туннелирование соединения
 - Проброс порта
 - Конфигурация соединения
 
 1. Туннелирование соединения возможно следующим образом
 ```
   ssh -i <key_path> -A -J [username@]<jump_host_ip> [username@]<internal_host_ip>
   
   ssh -i ~/.ssh/yc_key_priv -A -J appuser@158.160.52.160 appuser@10.128.0.30
 ```
 2. Проброс порта достигается следующими коммандами

```
   ssh -L 2222:10.128.0.30:22 158.160.52.160
   
```
  Затем подключение возможно на локальный порт 2222, который будет перенаправлен на внутренний хост.
 
 3. Конфигурация соединения возможно созданием файла .ssh/config и добавлением следующих строк
``` 
Host bastion
	HostName 158.160.52.160
	User appuser
	IdentityFile ~/.ssh/yc_key_priv
Host someinternalhost
	HostName 10.128.0.30
	User appuser
	IdentityFile ~/.ssh/yc_key_priv
```

Данные для подключения используя Pritun: 
 
bastion_IP = 158.160.52.160
someinternalhost_IP = 10.128.0.30


Доп задание:
Проблема выпуска сертификата через nip.op -> большое количество запросов. Let's Encrypt не выпускает сертификат, просит подождать. 
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

