---
layout: page
title: Testing YAML and CSV files
---
## hello

### MetaDron [link h3](/FolderA/MetaDron/index)

### MetaDron v2.0 [another h3 link](/FolderA/FolderB/MetaDron-v2/index)

### just a list
1. uno
1. dos
1. tres

### pretty table
c1| c2
-:|:-:
hh|kk
fffff|878978
adas|fvdfv

## A ol from csv
{% for member in site.data.data_csv %}
1.  _{{ member.name }}_ _**{{ member.github }}**_
{% endfor %}

## A ul from yml
{% for member in site.data.data_yml %}
*  **{{ member.name }}**, _**{{ member.github }}**_
{% endfor %}

## hash in yml
{% for member in site.data.data_yml %}
{% for hash in member %}
{{hash[0]}}:**{{hash[1]}}**
{% endfor %}
{% endfor %}
- - - 

## Table from csv (tricky)

| | |
|---|---|{% for member in site.data.data_csv %}{% if 1 == 1 %}
|**{{ member.name | strip }}**|_{{ member.github | strip }}_|{% endif %}{% endfor %}

## from JSON
{% assign santi = site.data.data_json | json %}
{{ santi }}
{{ santi.name }}
{{ santi.data[2]}}

## JSON to table very tricky

| | | | |
|--:|---|---|---|---|{% for hash in santi %}{% if 1 == 1 %}
|{{forloop.index}}||_{{hash[0]}}_||**{{hash[1]}}**|{% endif %}{% endfor %}

 
## Procesando multiples archivos de datos CSV
{% for files in site.data.multi %}
{{ files[0] }}: "{{ files[1][0].value}}"
{% for data in files[1] %}
{{data.key}}--{{data.value}}
{% endfor %}
{% endfor %}

## Y convirtiendolos en tablas
{% for files in site.data.multi %}
-

|{{ files[0] }}|{{ files[1][0].value}}|
|---|---|{% for data in files[1] %}
|{% for hash in data %}{{hash[1]}}|{% endfor %}{% endfor %}
{% endfor %}