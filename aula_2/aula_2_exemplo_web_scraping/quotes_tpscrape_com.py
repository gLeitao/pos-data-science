# -*- coding: utf-8 -*-
import scrapy


class QuotesTpscrapeComSpider(scrapy.Spider):
    name = 'quotes.tpscrape.com'
    allowed_domains = ['quotes.toscrape.com']
    start_urls = ['http://quotes.toscrape.com/']

    def parse(self, response):
        for quote in response.css('.quote'):
            text = quote.css('span.text::text').get()
            yield {'text': text}
