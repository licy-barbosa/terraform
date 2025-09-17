#!/bin/bash
echo "Hello, World" > ~/mensaje.txt

yum install -y # actualizar servidor 
yum install -y httpd # instalar apache
systemctl start httpd # iniciar apache
systemctl enable httpd # habilitar apache al iniciar el servidor