FROM python:3

LABEL maintainer="leonelfeukouo"

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -u 999 -G sudo -ms /bin/bash worbprezz

WORKDIR /usr/src/app
RUN chown worbprezz:worbprezz /usr/src/app -R

COPY requirements.txt .
USER worbprezz
RUN pip install --no-cache-dir -r requirements.txt --no-warn-script-location

COPY templates/ ./templates/

COPY . .

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]