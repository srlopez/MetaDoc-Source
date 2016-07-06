{% comment %}
   TOC
   {{page.doc-seq}}/
{% endcomment %}

{% assign pages = site[page.collection] | sort: 'page-num' %}
{% for page in pages %}
{% if forloop.index == 1 %}{% continue %}{% endif %}
{{page.page-num}}.- [{{ page.title }}]({{page.url | prepend: site.baseurl }})
{% if page.subtitle or page.sections %}{% assign spaces = page.page-num | size | plus:1 %}{% for i in (1..spaces) %}&nbsp;{% endfor %}{% if page.subtitle %}_{{page.subtitle}}_{% endif %}{% if page.subtitle and page.sections %}, {% endif %}{{page.sections | join:' | '}}
{% endif %}
{% endfor %}