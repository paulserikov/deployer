deployer
========

Simple site deployer on localhost

Просто положите в корень проекта папку deploy и файлик deploy.sh<br>
Что делает deploy.sh? Создает все симлинки и загружает конфигурацию виртуалхоста apache2,
подмонтируя проект на домен <project_name>.local<br>

В скрипте используется сервер apache2, редактор medit, браузер firefox, а также следующие утилиты linux:<br>
<ul>
<li>basename</li>
<li>cd</li>
<li>cp</li>
<li>chmod</li>
<li>cat</li>
<li>echo</li>
<li>grep</li>
<li>ln</li>
<li>ls</li>
<li>pwd</li>
<li>rm</li>
<li>sed</li>
<li>sudo</li>
</ul>
