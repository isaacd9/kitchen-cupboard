# Kitchen Cupbord

### Purpose

Kitchen Cupboard serves as a local, write-through cache of resources to be used
along with test-kitchen. By using a cache and avoiding accessing the network
for each download, performance can be improved in testing enviromnets. While
you will likely see some performance gains in all scenarios, this solution
is specifically intended for enviroments where the user is connected to
application repositories through a VPN and network is a significant bottleneck.

### Requirements
  - Latest version of test-kitchen
  - Most recent version of Chefdk

### Architecture

Kitchen Cupboard provides a virtual machine running that exposes ports 80 and
443 as HTTP and HTTPS proxies respectively. Each request made through the
proxies will be cached locally, either in memory or on disk, according to
Squid's internal caching policies. By default, there is 1 gigabyte of memory
cache and 7000mb of disk cache with a 512mb max object size. These be modified
by overwriting ```default['open_localdev_proxy']['squid']['cache_mem']```,
```default['open_localdev_proxy']['squid']['cache_size']```, and
```default['open_localdev_proxy']['squid']['max_obj_size']```. By default,
cached objects are persistant accross destory/rebuild cycles of the virtual
machine.  This is accomplished by mounting a VirtualBox Shared Folder and
writing cache objects to that location. Realizing that this may inhibit
performance in some cases, this can be modified with the ```
default['open_localdev_proxy']['squid']['cache_dir']``` directive. Once a cache
is built you will need to manually purge the cache directory (.cache) in this
directory.

### Platform

The proxy is running on a RHEL6 instance inside a vagrant virtual machine.

### Use
  - Run ```$ kitchen converge``` inside this directory. This will start a virtual machine with the proxy running.
  - Configure the ```.kitchen.yml``` of your project to be on the same shared network as this proxy, by adding the directive:
  ```ruby
    network:
      - ["private_network", {ip: "172.16.1.XXX"}]
  ```
  Where XXX is from 4-255
  - Add the lines:
  ```ruby
    ENV['HTTP_PROXY'] = "172.16.1.3:80"
    ENV['HTTPS_PROXY'] = "172.16.1.3:443"
  ```
  to the top of your default recipe to ensure that the proxies are used accross the chef-client run
  - Enjoy faster downloads of artifacts during chef-client runs.


