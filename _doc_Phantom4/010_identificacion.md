---
title: Descripción 
subtitle: Fabricante, modelo y número de serie ...
---

## DESCRIPCIÓN DEL SISTEMA

El Phantom 4 es un cuadricóptero de reducidas dimensiones, englobado en la categoría de peso inferior a los 2kg. Dispone de cámara alta definición con grabación en formato 4K y transmisión de imágenes a tierra en HD, la cámara está incluida con el gimbal estabilizado de 3 ejes, controlable por el piloto mediante la emisora, ayudado por una pantalla o dispositivo móvil que muestra al piloto imágenes y telemetría en tiempo real.
Tiene como sistemas de seguridad la vuelta al punto de despegue de forma automática en el caso de perder la comunicación con el piloto o por tener la batería demasiado baja para seguir volando



Los datos de Fabricante, modelo y número de serie de la aeronave, motor, hélices, soporte de la carga de pago y carga de pago, piloto automático y emisora de control, son los que se describen acontinuación. 

| |   | |   |
|=|==:|=|:==|
{% for x in site.data.phantom4.parts %}
||{{ x[0] }}||**{{x[1]}}**{% endfor %}|