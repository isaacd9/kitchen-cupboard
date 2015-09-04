default['open_localdev_proxy']['proxy']['enabled'] = false
default['open_localdev_proxy']['proxy']['http_proxy'] = ''
default['open_localdev_proxy']['proxy']['https_proxy'] = ''

default['open_localdev_proxy']['squid']['network'] = "172.16.1.0/24"
default['open_localdev_proxy']['squid']['port'] = ["80","443"]
default['open_localdev_proxy']['squid']['cache_mem'] = '1024'
default['open_localdev_proxy']['squid']['max_obj_size'] = 512
default['open_localdev_proxy']['squid']['cache_size'] = 7000
default['open_localdev_proxy']['squid']['cache_dir'] = '/var/spool/shared-cache/.cache'

