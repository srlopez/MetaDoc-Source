---
title: Planos, diagramas y esquemas
subtitle: Fotografías con dimensiones del vehículo Aero, de 3 vistas
---
## Dimensiones
{% for x in site.data.phantom4.dimensions.data %}
* {{x[0]}}: **{{x[1]}}**{% endfor %}
![alt text]({{ site.baseurl }}{{site.data.phantom4.images-dir}}/{{site.data.phantom4.dimensions.dimensionsimg }} "Phantom4 dimensiones")


## Vista frontal

![Phantom4 frontal]({{ site.baseurl }}{{site.data.phantom4.images-dir}}/{{site.data.phantom4.views.frontimg }}){: align="right"}
{% for x in site.data.phantom4.views.front %}
_{{x[0]}}_.- **{{x[1]}}**{% endfor %}

<br><br><br>

## Vista posterior

![Phantom4 posterior]({{ site.baseurl }}{{site.data.phantom4.images-dir}}/{{site.data.phantom4.views.rearimg }}){: align="right"}

{% for x in site.data.phantom4.views.rear %}
_{{x[0]}}_.- **{{x[1]}}**{% endfor %}

<br><br><br><br><br><br><br><br>
{: height="36px" width="36px"}

## Vista Inferior

![Phantom4 inferior]({{ site.baseurl }}{{site.data.phantom4.images-dir}}/{{site.data.phantom4.views.upperimg }}){: align="right"}

{% for x in site.data.phantom4.views.upper %}
_{{x[0]}}_.- **{{x[1]}}**{% endfor %}


