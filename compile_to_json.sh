#!/bin/bash

# Папка, в которой лежат репозитории (например, proxy и hosted)
#REPO_DIR="./proxy/docker/"
REPO_DIR="./proxy/"
#REPO_DIR="./hosted/"

# Создаем или перезаписываем файл repositories.json
echo "[" > repositories.json

# Собираем все JSON-файлы из подкаталогов proxy и hosted
find "$REPO_DIR" -type f -name "*.json" | while read file; do
    # Добавляем содержимое файла в repositories.json
    cat "$file" >> repositories.json
    
    # Добавляем запятую для разделения объектов, кроме последнего
    if [[ "$file" != $(find "$REPO_DIR" -type f -name "*.json" | tail -n 1) ]]; then
        echo "," >> repositories.json
    fi
done

# Завершаем массив в файле
echo "]" >> repositories.json

echo "Файл repositories.json создан."
