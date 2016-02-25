FROM praekeltfoundation/python-base

ENV SUPERVISOR_VERSION "3.2.1"
RUN pip install supervisor==$SUPERVISOR_VERSION

# Mimic the Debian/Ubuntu config file structure
ADD ./supervisor.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /etc/supervisor/conf.d && \
    mkdir -p /var/log/supervisor

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
