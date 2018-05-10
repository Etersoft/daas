upstream logdb-{{ project['name'] }} {
    server logdb:{{ project['logdb']['port'] }} fail_timeout=0;
}
