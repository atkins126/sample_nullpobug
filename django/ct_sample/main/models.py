# coding: utf-8
import os
import datetime
from django.db import models
from multicontents.models import MultiContentItem

class Event(MultiContentItem):
    begin_at = models.DateTimeField(u'開始日時', default=datetime.datetime.now())
    end_at = models.DateTimeField(u'終了日時', default=datetime.datetime.now())
    place = models.TextField(u'場所')

    class Meta:
        ordering = ('begin_at',)

class DownloadItem(MultiContentItem):
    file = models.FileField(u'ファイル', upload_to='file/')

    def basename(self):
        return os.path.basename(self.file.name)
