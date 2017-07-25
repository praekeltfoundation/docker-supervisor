ARG VARIANT
FROM praekeltfoundation/python-base:2${VARIANT:+-$VARIANT}

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Mimic the Debian/Ubuntu config file structure
COPY supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /etc/supervisor/conf.d \
             /var/log/supervisor

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
