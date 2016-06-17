FROM praekeltfoundation/python-base

ENV SUPERVISOR_VERSION "3.3.0"
RUN pip install supervisor==$SUPERVISOR_VERSION

# Mimic the Debian/Ubuntu config file structure
ADD ./supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /etc/supervisor/conf.d \
             /var/log/supervisor

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
