import os
import requests

# Скачиваем файл
response = requests.get('https://raw.githubusercontent.com/sngvy/AntiKeen/refs/heads/main/AntiKeen.lst', stream=True)
with open('AntiKeen.tmp', 'wb') as f:
    for chunk in response.iter_content(chunk_size=8192):
        f.write(chunk)

# Читаем содержимое файла
with open('AntiKeen.tmp', 'r', encoding='utf-8') as file:
    lines = file.readlines()

# Удаляем временный файл
os.remove('AntiKeen.tmp')

# Настройки нарезки
chunk_size = 1024

# Создаем папку AntiKeen, если она не существует
if not os.path.exists('AntiKeen'):
    os.makedirs('AntiKeen')

# Режем файл на части и сохраняем
for i in range(0, len(lines), chunk_size):
    file_number = i // chunk_size + 1
    output_filename = os.path.join('AntiKeen', f'AntiKeen_{file_number}.bat')
    with open(output_filename, 'w', encoding='utf-8') as out_file:
        out_file.writelines(lines[i:i + chunk_size])