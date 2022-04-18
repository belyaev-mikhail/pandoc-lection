---
title: Реляционные домены
author:
- Марат Ахин
- Михаил Беляев
date: \today
---

# Вспомним анализ диапазонов

Простой пример с двумя переменными

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{IntervalChart}
\end{center}

# Вспомним анализ диапазонов

А добавим-ка мы ограничение `x >= y`

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{IntervalChartLimited}
\end{center}

Может ли это выразить интервальный домен?

# Relational vs Nonrelational domains

- Решётка интервалов не учитывает связи между переменными
- Такие домены называются нереляционными (nonrelational)
- Существует целый класс доменов, которые связи учитывают

Если вспомнить лекцию про path-sensitivity, там эта проблема тоже всплывала

# Сложности представления

- Вообще говоря, даже для двух переменных возможны любые фигуры
- Реалистично говоря, можно учитывать только линейные зависимости

# Convex polygon domain

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{ConvexPolygon}
\end{center}

# Convex polyhedra

- Домен выпуклых многогранников
- N-мерный многогранник, где N --- число переменных
- Описывается системой линейных неравенств над переменными

# Infinite polyhedra

Вообще говоря, фигура может быть бесконечной

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{InfinitePolygon}
\end{center}

# Convex polyhedra: более формально

Пусть

$$
x = (x_1, x_2, x_3 \ldots x_N)^T
$$

есть набор всех переменных в программе

Тогда выпуклый многогранник над $x$ можно представить

- Как множество значений для $x$
    - Неясно, как представлять бесконечные многогранники
- Как набор линейных неравенств

# Convex polyhedra: представление в виде уравнений

$$
\mathbb{P} = \left\{x \in \mathbb{Q}^n \mid Ax \leq \beta \text{ и } Dx = \xi\right\}
$$

$$
\mathbb{C}_\mathbb{P} = \left\{Ax \leq \beta, Dx = \xi\right\}
$$

\centering или

$$
\mathbb{C}_\mathbb{P} = \left\{A, \beta, D, \xi\right\}
$$

# Convex polyhedra: представление в виде вершин

- Множество *вершин* $\mathbb{V} \subset \mathbb{Q}^n$
- Множество *лучей* $\mathbb{R} \subset \mathbb{Q}^n$   
- Множество *прямых* $\mathbb{Z} \subset \mathbb{Q}^n$

Тогда

$$
x = \sum_{i = 1}^{|\mathbb{V}|} \lambda_i v_i + \sum_{i = 1}^{|\mathbb{R}|} \mu_i r_i + \sum_{i = 1}^{|\mathbb{Z}|} \nu_i z_i
$$

$$
\forall \lambda_i, \mu_i, \nu_i \mid \lambda_i, \mu_i \geq 0\text{ и }\sum \lambda_i = 1
$$

$$
\mathbb{G}_\mathbb{P} = \left\{\mathbb{V}, \mathbb{R}, \mathbb{Z}\right\}
$$

# 

- Представление в виде уравнений также называют *матричным*
- Представление в виде вершин также называют *генераторным*

#

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{PolyhedraExample1}
\end{center}

\begin{align*}
\mathbb{C}_\mathbb{P} &= \left\{-x_1 \leq -1, x_1 \leq 4, -x_2 \leq -2, x_2 \leq 4\right\} \\
\mathbb{G}_\mathbb{P}  &= \left\{\mathbb{V} = \left\{(1, 2), (1, 4), (4, 2), (4, 4)\right\}, \mathbb{R} = \varnothing, \mathbb{Z} = \varnothing\right\}
\end{align*}

#

\begin{center}
\vfill
\includegraphics[height=0.7\textheight]{PolyhedraExample2}
\end{center}

\begin{align*}
\mathbb{C}_\mathbb{P} &= \left\{-x_2 \leq -2, x_2 \leq 2x_1\right\} \\
\mathbb{G}_\mathbb{P}  &= \left\{\mathbb{V} = \left\{(1, 2)\right\}, \mathbb{R} = \left\{(1, 2), (1, 0)\right\}, \mathbb{Z} = \varnothing\right\}
\end{align*}

# Решётка многогранников (polyhedra lattice)

- Элемент решётки --- $P = \left\{C_P, G_P\right\}$
- Отношение включения согласно геометрическому смыслу
- Пересечение --- геометрическое пересечение
- Объединение --- выпуклая оболочка геометрического объединения

- Как и с диапазонами, для каждого оператора свой *eval*
- Как и с диапазонами, нужно проводить widening

# Зачем вообще нужно два представления

- В оригинальной статье более 40 операторов
- Рассмотрим два самых простых: $\sqcup$ и $\sqcap$

- $\sqcup$ элементарен в генераторах --- это просто объединение всех множеств $\mathbb{V}, \mathbb{R}, \mathbb{Z}$
    - Экспонента в уравнениях
- $\sqcap$ элементарен в уравнениях --- мы просто сливаем вместе системы
    - Экспонента в генераторах

Трансформация между представлениями --- в худшем случае $O(nc^{2^{n+1}})$ (Алгоритм Черниковой)

# Дуализм представления многогранников

- Если у нас есть **оба** представления -- получить **хотя бы одно** всегда просто
- Если обрабатывать операторы лениво, зачастую это позволяет снизить сложность на порядки

# Fast polyhedra (ELINA)

- Можно разделить все переменные на старые добрые disjoint sets
- Строить оба представления только для них
- Из-за безумной размерности задачи это позволяет получить ускорение на *несколько порядков*

# Промежуточный итог

В царстве численных доменов есть два полюса

- Ranges: простой, быстрый, неточный
- Convex polyhedra: очень точный, но очень небыстрый

Есть ли что-то посередине?

# Разностные матрицы

- aka Hexagonal domain

- Разрешены только зависимости вида $x - y \leq c$
- Между всеми парами переменных (и $0$) формируется разреженная матрица имеющихся зависимостей
- Также эту матрицу можно рассматривать как матрицу смежности некоторого графа (называемого *графом потенциалов*)

# Разностные матрицы: пример

::: columns

:::: {.column width=30%}
\vskip0.2\textheight
\begin{align*}
x &\leq 4 \\
-x &\leq -1 \\
y &\leq 3 \\
-y &\leq -1 \\
x - y &\leq 2 \\
y - x &\leq 1.5 \\
\end{align*}
::::

:::: {.column width=30%}
\vskip0.3\textheight
$$
\begin{array}{r|ccc}
~  & 0      & x      & y      \\\hline
0  & \infty & 4      & 3      \\
x  & -1     & \infty & 1.5    \\
y  & -1     & 2      & \infty \\
\end{array}
$$
::::

:::: {.column width=40%}
\vskip0.3\textheight
\begin{center}
\includegraphics[height=0.7\textheight]{PotentialGraph}
\end{center}
::::

:::

# Решётка разностных матриц

- $A \sqsubseteq B$ iff $A \leq B$
    - Здесь $\leq$ это поэлементое сравнение, т.е. уже частичный порядок
- $C = A \sqcup B$ iff $\forall i, j : C_{ij} = \mathit{max}(A_{ij}, B_{ij})$
- $C = A \sqcap B$ iff $\forall i, j : C_{ij} = \mathit{min}(A_{ij}, B_{ij})$

- Другие операции строятся похожим образом

# Решётка разностных матриц: итоги

- При наличии хороших матричных реализаций скорость сравнима с диапазонами
- Очень ограничены виды уравнений

# Восьмигранники

- aka Octagon domain
- Разрешены зависимости вида $\pm{}x \pm y \leq c$

- Зависимости вида $x \leq c$ задаются как $x + x \leq 2c$
- Зависимости вида $x \geq c$ задаются как $-x - x \leq 2c$

- Почему восьмигранник?
    - Естественным образом у восьмигранника максимум 8 сторон

# Решётка восьмигранников

Октагон для $n$ переменных можно выразить как разностную матрицу $2n$ переменных:

Превращаем каждую переменную $x$ в две переменных $x^{-}$ и $x^{+}$

\begin{align*}
-x - y \leq c &\quad\Rightarrow\quad x^{-} - y^{+} \leq c \\
x + y  \leq c &\quad\Rightarrow\quad x^{+} - y^{-} \leq c \\
x - y  \leq c &\quad\Rightarrow\quad x^{+} - y^{+} \leq c \\
-x + y \leq c &\quad\Rightarrow\quad y - x \leq c \\
\end{align*}

# Разностные матрицы и восьмигранники: расширения

- Можно использовать гиперматрицы с количеством измерений больше 2
    - Тогда будут уравнения вида $x - y - z \leq 2$
- Обычно так не делают

# Выпуклые численные домены: итоги

- По точности
    - ranges $<$ hexagon $<$ octagon $\ll$ polyhedra
- По производительности
    - ranges $>$ hexagon $>$ octagon $\gg$ polyhedra

# Невыпуклые численные домены

- Можно ли сделать невыпуклый домен?

- Самый простой вариант --- powerset над любым выпуклым доменом
    - Даже для диапазонов это работает крайне плохо

- Ознакомимся с другими вариантами (крайне поверхностно)

# Невыпуклые численные домены: пончик

- Домен пончиков (или бубликов): Donut domain
- Элемент: $\{A, B\}$ где $A$ и $B$ --- элементы двух выпуклых доменов (возможно, разных)

- А -- это окружность, обрабатывается как в оригинальном домене
- B -- это *дырка*, особым образом перевернутая решётка

\begin{center}
\includegraphics[height=0.5\textheight]{DonutExample}
\end{center}

# Невыпуклые численные домены: коробки

- Домен коробок: Boxes domain
- По сути, powerset диапазонов, но хранится он в особой структуре данных LDD (линейные решающие диаграммы)
- В любой момент LDD можно схлопнуть в один диапазон
- Значитель эффективнее, чем powerset, за счёт алгоритмов решения и объединения/пересечения LDD

\begin{center}
\includegraphics[height=0.5\textheight]{BoxesDomain}
\end{center}

# Невыпуклые численные домены: конгруэнция

- Элемент домена -- линейное конгруэнтное соотношение $a \equiv b [c]$
    - Это означает, что $a$ принадлежит множеству $\{ \forall k \in \mathbb{W} \mid b + ck \}$
- Естественным образом аппроксимирует последовательности в циклах, если они построены на сумме с константой
- Используются решатели диофантовых уравнений

# В следующей серии

\begin{center}
\includegraphics[width=\textwidth]{nobody-knows}
\end{center}
