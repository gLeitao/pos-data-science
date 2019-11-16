# -*- coding: utf-8 -*-
import scrapy


class BooksToscrapeComSpider(scrapy.Spider):
    name = 'books.toscrape.com'
    allowed_domains = ['books.toscrape.com']
    start_urls = ['http://books.toscrape.com/']

    def parse(self, response):
        for product in response.css('.product_pod'):
            url = product.css('.image_container a::attr(href)').get()
            # print('---------------------------------------------------------------------')
            if url:
                yield response.follow(url, self.get_book_information)
            # print('---------------------------------------------------------------------')
            #yield {'URL': url}
            # livro = self.get_book_information(response, url)

        # urlN = response.css('.pager .next a::attr(href)').get()
        # if urlN:
        #     yield response.follow(urlN)


    def get_book_information(self, response):
        nome = response.css('.thumbnail img::attr(alt)').get()
        preco = response.css('.price_color::text').get()
        disponivel = response.css('.instock.availability::text').get()
        print('Disponivel', disponivel)
        yield {'Livro': nome,
               'Preco': preco,
               'Disponivel': disponivel}
