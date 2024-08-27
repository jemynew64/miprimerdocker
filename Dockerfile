# Usar una imagen base de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones de PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copiar archivos de la aplicación al contenedor
COPY . /var/www/html

# Establecer permisos para los directorios necesarios
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Habilitar el módulo de reescritura de Apache
RUN a2enmod rewrite

# Exponer el puerto 80 para el tráfico web
EXPOSE 80

# Iniciar Apache en el contenedor
CMD ["apache2-foreground"]
