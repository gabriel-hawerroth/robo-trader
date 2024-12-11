# Usar a imagem base oficial do Python 3.12 slim para economia de espaço
FROM python:3.12-slim

# Instalar dependências de sistema necessárias
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar TA-Lib
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -xzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && \
    ./configure --prefix=/usr && make && make install && \
    cd .. && rm -rf ta-lib ta-lib-0.4.0-src.tar.gz

# Criar o diretório de trabalho
WORKDIR /app

# Copiar o arquivo requirements.txt e instalar dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar os arquivos do projeto (opcional: caso já tenha o código)
COPY . .

# Comando padrão ao iniciar o container (ajuste conforme o script principal)
CMD ["python"]
