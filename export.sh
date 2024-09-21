#!/bin/bash

# Nexus credentials
source nexus_credentials.env

# Получаем список всех репозиториев
curl -u $USERNAME:$PASSWORD -X GET "$NEXUS_URL/service/rest/v1/repositorySettings" -H 'accept: application/json' -o repositories.json

# Открываем файл repositories.json и проходим по каждому репозиторию
jq -c '.[]' repositories.json | while read repo; do
    # Извлекаем значения name, type и format с помощью jq
    name=$(echo "$repo" | jq -r '.name')
    type=$(echo "$repo" | jq -r '.type')
    format=$(echo "$repo" | jq -r '.format')
    
    # Определяем путь к папке в зависимости от type и format
    dir_path="${type}/${format}"
    
    # Создаем папку, если она еще не существует
    mkdir -p "$dir_path"
    
    # Сохраняем репозиторий в файл с именем name.json
    echo "$repo" | jq '.' > "${dir_path}/${name}.json"
    
done 
cp repositories.json repositories.json.back
echo "Репозитории успешно раскиданы по папкам."

# # Извлекаем имена репозиториев и экспортируем их настройки
# jq -r '.[].name' repositories.json | while read repo_name; do
#     echo "Экспорт настроек для репозитория $repo_name"
#     curl -u $USERNAME:$PASSWORD -X GET "$NEXUS_URL/service/rest/v1/repositories/$repo_name" -H 'accept: application/json' -o "${repo_name}_settings.json"
# done

