{% comment %}

{% endcomment %}

{% if item.url %}
<li>
<a href="{{item.url | prepend: site.baseurl }}">{{item.name}}</a>
</li>
{% endif %}

{% if item.collection %}
{% assign url = site[item.collection][0]['url'] %}
<li>
<a href="{{url | prepend: site.baseurl }}">{{item.name}}</a>  
</li>
{% endif %}

{% if item.submenu %}
{% assign id=id|plus:1 %}
<input id="menu{{id}}" type="checkbox">
<label for="menu{{id}}">{{item.name}}</label>
<ul>
  {% for item in item.submenu %}
  {% include doc_sidebar.md %}
  {% endfor %}
</ul>
{% endif %}

{% if item.include %}
{% assign id=id|plus:1 %}
{% assign url = site[item.include][0]['url'] %}
<input id="menu{{id}}" type="checkbox">
<label for="menu{{id}}">{{item.name}}</label>
<ul>
  {% for item in site.data.doc_collections[item.include] %}
  {% include doc_sidebar.md %}
  {% endfor %}
</ul>
{% endif %}


{% if item.root %}
{% assign menu=include.menu %}
{% assign id=0 %}
{% for item in menu %}
{% include doc_sidebar.md %}
{% endfor %}
{% endif %}


