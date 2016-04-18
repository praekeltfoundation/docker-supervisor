FROM praekeltfoundation/python-base

ENV SUPERVISOR_VERSION "3.2.3"
RUN pip install supervisor==$SUPERVISOR_VERSION

# Mimic the Debian/Ubuntu config file structure
ADD ./supervisord.conf /etc/supervisord.conf
RUN mkdir -p /etc/supervisord.d && \
    mkdir -p /etc/supervisor/conf.d && \
    mkdir -p /var/log/supervisor

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
