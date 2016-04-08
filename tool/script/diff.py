#!/home/unix1986/py27/bin/python -u
# -*- coding:utf8 -*-

import urllib2
import urllib
import json
import threading
import Queue

_g_old_url_template = 'http://10.172.200.107:15601/' \
    + 'jdoclist.htm?kw=%s&orig_kw=&start=0&count=20&src=&corr=' \
    + '&corr_mix=&param=sep_code:utf8|sep_synm:1|sep_fuzzy:1' \
    + '&from=&voice=&req_id=&province=&city=&district=&township=' \
    + '&village=&mso_x=&mso_y=&diyu_province=&diyu_city=&sb=0&dbglv=3850483174'

_g_new_url_template = 'http://test18.se.zzzc:48370' \
    + '/search.html?q=%s&s=0&debug_qfedd=3'

_g_diff_fns = 'std_diff_fn;no_diff_fn'
_g_topn = 5
_g_concurrency = 5
_g_timeout = 60
_g_out_file = './data/data.txt'
_g_hostlist = './data/hostlist.txt'
_g_querylist = './data/query.txt'

# diff functions
def no_diff_fn(jold, jnew):
    # return arg: (symbol, return value, if diffexists)
    return (False, 'no_diff_fn', -1)

def std_diff_fn(jold, jnew):
    new_size = len(jnew['result'])
    base_size = len(jold['result'])
    same = 0
    for i in range(_g_topn):
        if i < base_size and i < new_size:
            ai = jnew['result'][i]
            bi = jold['result'][i]
            if not ai['md5'].endswith(bi['md5']):
                return (True, 'std_diff_fn', i + 1)
            same += 1
        elif i >= base_size and base_size == new_size:
            return (False, 'std_diff_fn', -1)
    if same == _g_topn:
        return (False, 'std_diff_fn', -1)
    return (True, 'std_diff_fn', min(base_size, new_size))

def diff(old, new, diff_fns):
    for fn in diff_fns.split(';'):
        fn = fn.strip()
        stat, name, result = eval(fn)(old, new)
        if stat:
            break
    return (stat, name, result)

# thread function
def crawl(old_url, new_url, parse_cb, tm = 60):
    stat = True
    try:
        old_res = urllib2.urlopen(old_url, timeout = tm).read()
        new_res = urllib2.urlopen(new_url, timeout = tm).read()
        old_obj, new_obj = parse_cb(old_res, new_res)
    except:
        old_obj = None
        new_obj = None
        stat = False
    return (stat, old_obj, new_obj)

# parse function
def rank_up_parser(old_res, new_res):
    old_obj = json.loads(old_res)
    new_obj = json.loads(new_res)
    return (old_obj, new_obj)

class Spider(threading.Thread):
    def __init__(self, in_queue, out_queue, diff_fns, timeout = 60):
        threading.Thread.__init__(self)
        self._in_queue = in_queue
        self._out_queue = out_queue
        self._diff_fns = diff_fns
        self._timeout = timeout
    def run(self): 
        while not self._in_queue.empty():
            old_url, new_url = self._in_queue.get()
            stat, old_obj, new_obj = crawl(
                old_url, new_url, rank_up_parser, self._timeout)
            if stat:
                result = diff(old_obj, new_obj, self._diff_fns)
            else:
                result = None
            self._out_queue.put((stat, old_url, new_url, result))

def format(result):
    if result[0]:
        return "%d\t%s\t%s\t%d\t%s\t%d" % (
            int(result[0]), result[1], result[2],
            int(result[3][0]), result[3][1], int(result[3][2]))
    else:
        return "%d\t%s\t%s" % (
            int(result[0]), result[1], result[2])

class Reporter(threading.Thread):
    def __init__(self, data_queue, out_file):
        threading.Thread.__init__(self)
        self._data_queue = data_queue
        self._out_file = out_file
        self._running = True
    def run(self):
        while self._running:
            try:
                result = self._data_queue.get(timeout = 5)
                format_res = format(result) 
                self._out_file.write(format_res + '\n')
            except Queue.Empty:
                continue
            except Exception:
                pass
            self._data_queue.task_done()
    def stop(self):
        self._running = False

def load_data(old_url_template,
        new_url_template,
        hostlist,
        querylist,
        out_queue):
    hosts = open(hostlist, 'r').readlines()    
    querys = open(querylist, 'r').readlines()
    host_num = len(hosts)
    query_num = len(querys)
    for i in range(query_num):
        j = i % host_num
        #query = urllib.urlencode({'kw' : querys[i].strip()})
        #host = hosts[j].strip()
        #old_url = old_url_template % (host, query)
        #new_url = new_url_template % (host, query)
        query = urllib.quote(querys[i].strip())
        old_url = old_url_template % query
        new_url = new_url_template % query
        out_queue.put((old_url, new_url))

if __name__ == '__main__':
    urls_queue = Queue.Queue()
    results_queue = Queue.Queue()
    load_data(_g_old_url_template,
              _g_new_url_template,
              _g_hostlist,
              _g_querylist,
              urls_queue)
    spiders = []
    for i in range(_g_concurrency):
        spiders.append(Spider(
            urls_queue, results_queue, _g_diff_fns, _g_timeout))
        spiders[-1].start()
    out_file = open(_g_out_file, 'w')
    reporter = Reporter(results_queue, out_file)
    reporter.start()
    for i in range(_g_concurrency):
        spiders[i].join()
    results_queue.join()
    reporter.stop()
    reporter.join()
    
# set vim: st=4 sts=4 sw=4 tw=80 et:
