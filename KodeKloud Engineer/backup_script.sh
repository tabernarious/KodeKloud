#!/bin/bash
zip -r /backup/xfusioncorp_news.zip /var/www/html/news/
scp /backup/xfusioncorp_news.zip clint@stbkp01:/backup/