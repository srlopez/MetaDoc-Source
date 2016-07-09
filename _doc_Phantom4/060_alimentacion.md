---
title: Sistema de energía 
---

## Descripción del sistema de alimentación eléctrica o de combustible

El sistema de alimentación es eléctrico y tiene estas características:

{% for x in site.data.phantom4.bateries.data %}
|||||• {{ x[0] }}||**{{x[1]}}**{% endfor %}|

<br>
El nivel de carga de las baterías puede verse en la batería físicamente (Led1-4) o también puede ser observado a distancia con la aplicación DJI Go.

![Phantom4 batería]({{ site.baseurl }}{{site.data.phantom4.images-dir}}/{{site.data.phantom4.bateries.bateriesimg }})
