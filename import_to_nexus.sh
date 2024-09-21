#!/bin/bash

# Настройки Nexus
source nexus_credentials.env

# Открываем файл repositories.json и проходим по каждому объекту JSON
jq -c '.[]' repositories.json | while read repo_json; do
    # Извлекаем имя и формат репозитория для формирования URL
    repo_name=$(echo "$repo_json" | jq -r '.name')
    repo_format=$(echo "$repo_json" | jq -r '.format')
    repo_type=$(echo "$repo_json" | jq -r '.type')

    # Формируем URL для API в зависимости от формата и типа репозитория
    api_url="$NEXUS_URL/service/rest/v1/repositories/$repo_format/$repo_type"
    
    # Отправляем запрос на создание репозитория в Nexus
    echo "Создание репозитория: $repo_name по URL $api_url"
    
    curl -u "$USERNAME:$PASSWORD" -X POST "$api_url" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -d "$repo_json"
    
    # Проверяем статус выполнения запроса
    if [ $? -eq 0 ]; then
        echo "Репозиторий $repo_name успешно создан."
    else
        echo "Ошибка при создании репозитория $repo_name."
    fi
done

echo "Импорт репозиториев завершён."
