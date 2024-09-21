#!/bin/bash

# Nexus credentials
source nexus_credentials.env

# Получаем список всех репозиториев
repos=$(curl -u "$USERNAME:$PASSWORD" -X GET "$NEXUS_URL/service/rest/v1/repositories" -H "accept: application/json")

# Проверяем, есть ли репозитории
if [ -z "$repos" ]; then
    echo "Нет доступных репозиториев для удаления."
    exit 1
fi

# Проходим по каждому репозиторию и удаляем его
echo "$repos" | jq -c '.[]' | while read repo; do
    repo_name=$(echo "$repo" | jq -r '.name')
    
    # Удаляем репозиторий
    echo "Удаление репозитория: $repo_name"
    curl -u "$USERNAME:$PASSWORD" -X DELETE "$NEXUS_URL/service/rest/v1/repositories/$repo_name"
    
    # Проверяем статус выполнения запроса
    if [ $? -eq 0 ]; then
        echo "Репозиторий $repo_name успешно удалён."
    else
        echo "Ошибка при удалении репозитория $repo_name."
    fi
done

echo "Все репозитории удалены."