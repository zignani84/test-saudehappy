# Definindo a imagem base
FROM php:8.0-fpm

# Instalando dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Definindo o diretório de trabalho
WORKDIR /var/www/html

# Copiando os arquivos do projeto
COPY backend .

# Instalando as dependências do Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalando as dependências do projeto
RUN composer install

# Expondo a porta padrão do Laravel
EXPOSE 9000

# Comando padrão para executar o servidor PHP
CMD ["php-fpm"]
