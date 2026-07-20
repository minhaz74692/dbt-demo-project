{% set fruits = ["Apple", "Orange", "Mango", "Banana", "Grapes"] %}

{% for fruit in fruits %}
    {% if fruit != "Mango" %}
        {{fruit}}
    {% else %}
        This is {{ fruit }}
    {% endif %}
{% endfor %}