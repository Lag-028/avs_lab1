#!/bin/bash

# Лабораторная работа №1
# Вариант 10
# Скрипт выполняет задания варианта последовательно.
# Запускать внутри Debian Dev Container.
# Перед запуском каталога ~/lab0 быть не должно.

cd ~

# ============================================================
# 1. Создание дерева каталогов и файлов
# ============================================================

mkdir lab0
cd lab0

mkdir -p claude_monet/hall/tables
mkdir -p claude_monet/hall/waiters
mkdir -p claude_monet/kitchen
mkdir -p claude_monet/office
mkdir nastya_room
mkdir free_tables

touch claude_monet/hall/tables/table_three
touch claude_monet/hall/tables/table_seven
touch claude_monet/hall/waiters/shift_list
touch claude_monet/hall/waiters/tip_report
touch claude_monet/hall/guest_requests
touch claude_monet/kitchen/vegetarian_menu
touch claude_monet/kitchen/barinov_order
touch claude_monet/office/vika_instruction
touch nastya_room/nastya_diary
touch evening_message

cat > claude_monet/hall/tables/table_three << 'TXT'
За третьим столиком ждут двух гостей
Гости заказали салат и горячее блюдо
Настя передала заказ на кухню
Счёт попросили принести после десерта
TXT

cat > claude_monet/hall/tables/table_seven << 'TXT'
Седьмой столик забронирован на вечер
Постоянные гости попросили старое меню
Костя готовит для них напитки
Настя проверяет заказ перед подачей
TXT

cat > claude_monet/hall/waiters/shift_list << 'TXT'
Настя обслуживает центральную часть зала
Саша работает у столиков возле окна
Первая смена начинается до открытия
После банкета официанты помогают закрыть зал
TXT

cat > claude_monet/hall/waiters/tip_report << 'TXT'
Третий столик оставил хорошие чаевые
Гости у окна поблагодарили Настю
На банкете чаевые разделили между официантами
Итоговый отчёт передали Вике
TXT

cat > claude_monet/hall/guest_requests << 'TXT'
Один гость просит блюдо без лука
Для ребёнка нужен небольшой десерт
Постоянный гость хочет поговорить с Бариновым
Настя уточняет каждый особый заказ
TXT

cat > claude_monet/kitchen/vegetarian_menu << 'TXT'
Овощной салат для Насти
Рататуй по рецепту Баринова
Тёплая закуска без мяса
Фруктовый десерт от Луи
TXT

cat > claude_monet/kitchen/barinov_order << 'TXT'
Все заказы передавать на кухню без задержки
Новое блюдо показывать шефу перед подачей
Настя отвечает за пожелания важных гостей
После смены подготовить общий отчёт
TXT

cat > claude_monet/office/vika_instruction << 'TXT'
Вика собирает официантов перед открытием
Настя проверяет готовность столиков
Во время смены жалобы записывают сразу
Вечером отчёты передают управляющей
TXT

cat > nastya_room/nastya_diary << 'TXT'
Настя пришла в ресторан вместе с Костей
До открытия она помогла украсить зал
Постоянные гости узнали Настю
После смены Костя ждал её у бара
TXT

cat > evening_message << 'TXT'
Сегодня в ресторане проходит большой банкет
Настя назначена старшей среди официантов
Вика проверит зал в шесть часов
Баринов ждёт первые заказы на кухне
TXT

# ============================================================
# 2. Установка прав доступа
# ============================================================

chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/hall
chmod 750 claude_monet/hall/tables
chmod u=rw,g=r,o= claude_monet/hall/tables/table_three
chmod 640 claude_monet/hall/tables/table_seven
chmod u=rwx,g=rx,o= claude_monet/hall/waiters
chmod 660 claude_monet/hall/waiters/shift_list
chmod u=rw,g=r,o=r claude_monet/hall/waiters/tip_report
chmod 644 claude_monet/hall/guest_requests
chmod u=rwx,g=rx,o=rx claude_monet/kitchen
chmod u=r,g=r,o=r claude_monet/kitchen/vegetarian_menu
chmod 640 claude_monet/kitchen/barinov_order
chmod 750 claude_monet/office
chmod u=rw,g=r,o= claude_monet/office/vika_instruction
chmod u=rwx,g=rx,o= nastya_room
chmod 640 nastya_room/nastya_diary
chmod 700 free_tables
chmod u=rw,g=r,o=r evening_message

echo "=== Структура и права после создания ==="
ls -lR

# ============================================================
# 3. Копирование, перемещение и создание ссылок
# ============================================================

cp nastya_room/nastya_diary claude_monet/office/waitress_report
cp -r claude_monet/hall/tables claude_monet/hall/tables_backup
ln -s ../claude_monet/hall/guest_requests nastya_room/today_requests
ln -s claude_monet/hall hall_entry
ln evening_message claude_monet/hall/shift_message
cat claude_monet/hall/tables/table_three claude_monet/hall/tables/table_seven > claude_monet/hall/reservation_plan
cat claude_monet/office/vika_instruction >> claude_monet/hall/waiters/shift_list
mv claude_monet/hall/waiters/tip_report claude_monet/office/evening_tips

echo "=== Структура после копирования, ссылок и перемещения ==="
ls -lR

# ============================================================
# 4. Поиск, фильтрация и обработка данных
# ============================================================

echo "=== Задание 4.1 ==="
ls -lR | grep '^-' | sort -k5,5n | tail -n 5

echo "=== Задание 4.2 ==="
grep -rhiE 'настя|гост' claude_monet nastya_room | grep -vi 'постоянн' | sort | head -n 6

echo "=== Задание 4.3 ==="
grep -ril 'гост' claude_monet/hall/tables claude_monet/hall/tables_backup | wc -l

echo "=== Задание 4.4 ==="
(head -q -n 1 claude_monet/hall/tables/*; tail -q -n 1 claude_monet/hall/tables/*) | grep -Ei 'столик|заказ' | sort -r

echo "=== Задание 4.5 ==="
grep -vi 'настя' claude_monet/hall/reservation_plan | grep -Ei 'гост|столик' | sort -r | head -n 4 | wc -w

echo "=== Задание 4.6 ==="
ls -lR | grep -E '^-[^[:space:]]+[[:space:]]+2[[:space:]]' | sort -k9,9r

echo "=== Задание 4.7 ==="
ls -lR | grep '^l' | sort -k9,9 | tail -n 1

# ============================================================
# 5. Удаление файлов, ссылок и каталогов
# ============================================================

rm nastya_room/nastya_diary
rm nastya_room/today_requests
rm hall_entry
rm evening_message
rm claude_monet/hall/shift_message
rm claude_monet/kitchen/barinov_order
rmdir free_tables
rm -r claude_monet/hall/tables_backup

echo "=== Итоговая структура ==="
ls -lR
