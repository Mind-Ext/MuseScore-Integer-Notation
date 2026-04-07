# /// script
# dependencies = ["jinja2"]
# ///
from jinja2 import Template
from textwrap import indent
import json


def translate_qml(template_file, shared_file, translations_file, langs=("en", "zh")):
    with open(template_file, "r", encoding="utf-8") as file:
        template_content = file.read()

    with open(shared_file, "r", encoding="utf-8") as file:
        shared_template = file.read()

    with open(translations_file, "r", encoding="utf-8") as file:
        translations = json.load(file)

    template = Template(template_content)
    shared_tmpl = Template(shared_template)

    for i, lang in enumerate(langs):
        render_context = {k: v[i] for k, v in translations.items()}
        shared_rendered = shared_tmpl.render(render_context)
        render_context["shared_functions"] = indent(shared_rendered, "    ")
        content = template.render(render_context)
        assert "{{" not in content
        output_path = f"translated/{template_file.split('.')[0]}_{lang}.qml"
        with open(output_path, "w", encoding="utf-8") as file:
            file.write(content)


if __name__ == "__main__":
    translate_qml("IntegerNotationInside.qml", "shared.js", "translation.json")
    translate_qml("IntegerNotationOutside.qml", "shared.js", "translation.json")
