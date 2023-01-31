---
title: Accueil
---

# {{ config.site_name }}

<img src="../assets/images/logo_heiafr_color.png">

Bienvenue sur le site du cours "{{ config.site_name }} {{ year }}" pour les étudiantes et étudiants
{%- if class_names|length > 1 %}
des classes {{ class_names[0:-1:] | join (', ') }} et {{ class_names | last }}
{%- else %}
de la classe {{ class_names | first }}
{%- endif %}
de la Haute école d'ingénierie et d'architecture de Fribourg.

!!! info "URL for this site"
    <span style="font-size: 1.1rem;">{{ config.site_url }}</span>
