# Базовый образ с Python 3.11.11
FROM python:3.11.11

# Установка метаданных
LABEL maintainer="your-email@example.com"
LABEL description="Docker image with Python 3.11.11 and required packages"

# Обновление системы и установка базовых зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    nano \
    sudo \
    apt-utils \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Обновление pip и установка setuptools/wheel
RUN pip install --upgrade pip && \
    pip install setuptools wheel

# Проверка версии Python и pip
RUN python --version && pip --version

# Очистка кэша
RUN apt-get clean && \
    rm -rf /tmp/* /var/tmp/*
