# Скачиваем файл
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/sngvy/AntiKeen/refs/heads/main/AntiKeen.lst' -OutFile 'AntiKeen.tmp'

# Читаем содержимое файла
$lines = Get-Content 'AntiKeen.tmp'

# Удаляем временный файл
Remove-Item 'AntiKeen.tmp'

# Размер одного фрагмента
$chunkSize = 1024

# Создаем папку AntiKeen, если она не существует
New-Item -Path .\AntiKeen -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

# Проходим по файлу и делаем нарезку
for ($i = 0; $i -lt $lines.Count; $i += $chunkSize) {
    # Определение имени файла
    $fileNumber = [Math]::Floor($i / $chunkSize) + 1
    $outputFile = Join-Path -Path .\AntiKeen -ChildPath "AntiKeen_$fileNumber.bat"

    # Выбор отрезка текущего размера
    $currentChunk = $lines[$i..($i + $chunkSize - 1)]

    # Сохраняем отрезок в файл
    $currentChunk | Set-Content $outputFile
}