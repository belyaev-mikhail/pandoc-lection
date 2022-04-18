---
title: Система работы с документами Pandoc
author:
- Михаил Беляев
date: \today
---

# 

- Систем работы с документами существует целая куча
- Очевидной кажется идея свести их все в одну

# Enter Pandoc

- Pandoc --- это универсальный конвертер документов
- "Швейцарский нож" работы с документами

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{PandocOverview.drawio}
\end{center}

# Pandoc: использование

Конвертировать markdown-файл в PDF с помощью LaTeX (форматы автоматически выводятся из имён файлов)

```bash
~$ pandoc document.md -o file.pdf
```

Конвертировать файл text в формате mediawiki в DOCX

```bash
~$ pandoc text -f mediawiki -t docx
```

# Pandoc Markdown

- Pandoc поддерживает много разных языков на входе
    - Даже tex и docx!
- Но основной язык -- это особенная разновидность markdown


# Pandoc Markdown: пример

`````md
## Borealis contracts

- A comment-based *language* based on **ACSL**

```C
// @requires a > 0
void foo(int a) {...}
```

- Supports stateful contracts using custom properties
- The whole standard library is annotated!
`````

# Pandoc Markdown: необычный язык разметки

- Поддерживает математику из \LaTeX из коробки
- Куча расширений
- Подсветка синтаксиса
- Цитаты и библиография
- Можно навешивать свои атрибуты почти на что угодно

# Pandoc Markdown: презентации

- Можно делать презентации!
    - И экспортировать их в slidy, s5, Powerpoint или Latex
- Синтаксис тот же самый, но есть пара доп. команд

- **Эта презентация сделана в Pandoc**

# Pandoc Markdown: презентации -- пример из доков

\tiny

```md
% Habits
% John Doe
% March 22, 2005

# Pandoc Markdown: что ещё можно делать

- Можно вставлять некоторые команды \LaTeX прямо в текст и они работают
- Как и куски чистого HTML
- Всякие кавычки и тире преобразовываются автоматически

# In the morning

## Getting up

- Turn off alarm
- Get out of bed

## Breakfast

- Eat eggs
- Drink coffee

# In the evening

## Dinner

- Eat spaghetti
- Drink wine

------------------

![picture of spaghetti](images/spaghetti.jpg)

## Going to sleep

- Get in bed
- Count sheep
```

# Насколько это применимо в реальности

- Хотите увидеть **по-настоящему** сложный документ в формате Pandoc -- откройте спецификацию Kotlin
- Или спецификацию Scala

# Pandoc: расширяемость

- Всё вышеизложенное -- ерунда

. . . 

- Настоящая *фишка* Pandoc -- это его кастомизируемость

# Pandoc: расширяемость

- Хотите генерировать документы не под стандартный шаблон -- пожалуйста
    - Все шаблоны для текстовых форматов легко редактируются
- Хотите добавить своих команд и использовать их -- легко
    - Поддерживаются макросы а-ля \LaTeX, но во всех доступных форматах
- Хотите кастомный заголовок/хвостовик в конкретном формате -- есть для этого аргументы
- Хотите сделать что-то ну совсем безумное?
    - ...

# Pandoc: Yaml headers

Можно сделать заголовок или отдельный файл в формате Yaml с настройками

\tiny

```yaml
---
title: The document title
author:
- name: Author One
  affiliation: University of Somewhere
- name: Author Two
  affiliation: University of Nowhere
...
```

\normalsize

Эти переменные доступны из шаблона

\tiny

```
$for(author)$
$if(author.name)$
$author.name$$if(author.affiliation)$ ($author.affiliation$)$endif$
$else$
$author$
$endif$
$endfor$
```

# Pandoc: фильтры

- Фильтр -- это программа, которая берёт на вход документ, что-то с ним делает и выдаёт его на выход
- Из коробки поддерживаются Haskell, Python и Lua
- Фильтров может быть сколько угодно на один запуск

# Pandoc: использование фильтра

Конвертировать markdown-файл в PDF с помощью LaTeX через фильтр filter.py

```bash
~$ pandoc document.md -o file.pdf --filter filter.py
```

Для любителей разбираться в деталях: это работает ±вот так

\scriptsize

```bash
~$ pandoc document.md -t json | filter.py tex | pandoc - -f json -t pdf
```



# Pandoc: что может сделать фильтр?

- Фильтр получает на вход документ в виде JSON
- Выдаёт его же в виде того же JSON

- В рамках этих ограничений фильтр может делать **всё**

Примеры из жизни:

- Вместо кода на каком-то языке скомпилировать его, запустить и вставить результат
- Вместо ascii-арта с картинкой отрендерить и вставить в документ саму картинку
- Взять сырые данные и сделать из них красивую табличку
- Особым образом обработать все заголовки

# Pandoc: что может сделать фильтр?

Примеры из production спецификации Котлина:

- Детекция битых ссылок
- Преобразование грамматики и вставка её в документ
- Поиск TODO и обработка их в зависимости от флагов сборки
- Вставка диаграмм (см. выше)

# Pandoc: кроме фильтров

Можно писать свои форматы ввода и вывода!

- Правда, поддерживается только Lua

```bash
~$ pandoc -t data/sample.lua
~$ pandoc -f my_custom_markup_language.lua -t latex -s
``` 

# Сегодня мы многое поняли

- Система Pandoc позволяет преобразовывать документы из кучи разных форматов
    - и презентации!
- Всё это очень гибко настраивается
- Любители писать программы могут обмазаться фильтрами и делать удивительные вещи

# 

- Документация по Pandoc: <https://pandoc.org/>
- Эта презентация: <https://github.com/belyaev-mikhail/pandoc-lection>
- Спека Котлина: <https://github.com/kotlin/kotlin-spec>
