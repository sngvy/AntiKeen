# Скачиваем файл
wget -O AntiKeen.tmp 'https://raw.githubusercontent.com/sngvy/AntiKeen/refs/heads/main/AntiKeen.lst'

# Читаем содержимое файла и удаляем временный файл
lines=$(cat AntiKeen.tmp)
rm AntiKeen.tmp

# Размер одного фрагмента
chunkSize=1024

# Создаем папку AntiKeen, если она не существует
mkdir -p AntiKeen

# Проходим по файлу и делаем нарезку
i=0
fileNumber=1
while IFS= read -r line; do
  # Определение имени файла
  if [ $((i % chunkSize)) -eq 0 ]; then
    outputFile="AntiKeen/AntiKeen_${fileNumber}.bat"
    fileNumber=$((fileNumber + 1))
    
    # Создаем новый файл, если достигли размера фрагмента
    if [ $i -ne 0 ]; then
      echo -n "" > "$outputFile"
    fi
  fi
  
  # Сохраняем строку в файл
  echo "$line" >> "$outputFile"
  
  i=$((i + 1))
done <<< "$lines"