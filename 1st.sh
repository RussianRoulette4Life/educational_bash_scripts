# Все исполняемые скрипты начинаются с шебанга. 
# Он говорит, какая программа будет исполнять скрипт.
# В данном случае это bash

#!/usr/bin/env bash

# Таким образом задаётся значение переменной.
# Можно задавать с кавычками, можно без, но рекомендуется их использовать.

VARIABLE_1=значение1

VARIABLE_2="value2"

# Для получения значения переменной перед её именем ставится "$"

ultimate_var="$VARIABLE_1 и $VARIABLE_2"
script_dir=$(dirname $0)
echo $ultimate_var

# Значение переменной можно удалить

unset ultimate_var
unset VARIABLE_1
unset VARIABLE_2

# Можно одновременно создавать переменные и экспортировать их

export RANDOM_DATA="ну типа рандом!"


# Один скрипт может вызывать другой.

source /etc/bash.bashrc

# Далее: парочка if

if [ -f 2nd.sh ]; then
	source 2nd.sh "$RANDOM_DATA"
else
	echo "2nd.sh не существует!"
fi

if [[ $PATH == *"/usr/bin"* ]]; then
	echo "Внутри PATH существует /usr/bin"
	whoami
else
	echo "а... как у вас программы запускаются??"
	whoami
fi

if [[ $((10+4)) == "14" && $((1/2)) == 0 ]]; then
	echo "bash умеет совершать простые математические операции! Но только над целыми числами"
	pwd
fi

## настоятельно рекомендую посмотреть 2nd.sh перед продолжением
# Теперь for (+ приколы с цветами)

echo -e "Также, тяжко в это поверить, но в терминалы \e[33mМОЖНО ВЫВОДИТЬ ЦВЕТА!\e[0m С помощью ansi escape кодов.\e[35m"

for i in $(seq 1 100); do
	echo -n "Привет, $i! "
done

echo -en "\e[0m"

for ELEMENT in $(ls /etc); do
	if [[ -f /etc/$ELEMENT ]]; then
		echo -n "/etc/$ELEMENT - файл; "
	else
		echo -n "/etc/$ELEMENT - каталог; "
	fi
done
echo -en "\n"

## В данном случае 2> /dev/null перенаправляет все ошибки (по типу доступ запрещён) на /dev/null, то есть вникуда.

for file in `find /etc -type f 2> /dev/null`; do
	if [[ -n $(grep -E "$USER" $file 2> /dev/null ) ]]; then
		echo "$file упомянает вас, $USER."
	fi
done

# Далее - case

case $1 in
	"")
		echo "В программу ничего не было подано как аргумент"
		;;
	"help")
		echo "Нужна помощь? ну не знаю зайди в интернет что ле"
		;;
	*)
		echo "Аргумент: $1"
		;;
esac

# По мелочи: перенапрявления вывода, "конвейер" и пр.

grep -n -E "echo" "$script_dir/1st.sh" > "$script_dir/echoes.txt"
echo -e "Содержание \e[3mechoes.txt\e[0m: " && cat "$script_dir/echoes.txt"
rm "$scrip_dir/echoes.txt"

