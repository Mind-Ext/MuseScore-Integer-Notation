from jinja2 import Template
import json


def translate_qml(template_file, translations_file, langs=("en", "zh")):
    with open(template_file, "r", encoding='utf-8') as file:
        template_content = file.read()

    with open(translations_file, "r", encoding='utf-8') as file:
        translations = json.load(file)

    template = Template(template_content)

    for i, lang in enumerate(langs):
        content = template.render({k: v[i] for k, v in translations.items()})
        assert "{{" not in content
        # make sure all variables are replaced
        output_path = f"translated/{template_file.split('.')[0]}_{lang}.qml"
        with open(output_path, "w", encoding='utf-8') as file:
            file.write(content)


if __name__ == "__main__":
    translate_qml("IntegerNotationInside.qml", "translation.json")
    translate_qml("IntegerNotationOutside.qml", "translation.json")
