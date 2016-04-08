#!/home/unix1986/py27/bin/python
from bs4 import BeautifulSoup
import urllib2
import traceback
import email
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

_g_url = "http://www.bjjs.gov.cn/tabid/3151/Default.aspx"

def format_soup(soup):
    if not isinstance(soup, BeautifulSoup):
        return ""
    title = soup.find(id = 'ess_ctr6850_FDCJY_SSHouse'
        '_Model_ctl00_Label_ModeulName').string.strip()
    table = soup.find(id = 'ess_ctr6850_FDCJY_SSHouse'
        '_Model_ctl00_GridView1')
    trs = table.find_all('tr')
    result = "%-s\n" % (title,)
    for tr in trs:
        tds = tr.find_all('td')
        if (len(tds) < 3): continue
        area_name = tds[0].find('a').string.strip()
        sale_card = tds[1].find('a').string.strip()
        open_time = tds[2].string
        result += "%-10s%-20s%-15s\n" % (area_name, sale_card, open_time)
    return result
    
def send_mail(subject = 'NULL',
    msg = 'NULL',
    from_addr = 'unix1986@qq.com',
    to_addrs = ['unix1986@qq.com', ]):
    msg = MIMEMultipart()
    msg['Subject'] = subject
    msg['From'] = from_addr
    msg['To'] = ','.join(to_addrs)
    msg.attach(MIMEText(msg, 'html', 'utf-8'))
    s = smtplib.SMTP('localhost')
    s.sendmail(from_addr, to_addrs, msg.as_string())
    s.quit()

if __name__ == '__main__':
    try:
        html_doc = urllib2.urlopen(_g_url, timeout = 60).read()
        soup = BeautifulSoup(html_doc, 'html.parser')
        result = format_soup(soup)
        print result,
        #send_mail("Test", "Test") 
    except:
        print traceback.format_exc()

# vim: set st=4 sw=4 sts=4 tw=80 et:
