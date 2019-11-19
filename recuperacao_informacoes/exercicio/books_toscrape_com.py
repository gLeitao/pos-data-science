# -*- coding: utf-8 -*-
import scrapy
import re


class BooksToscrapeComSpider(scrapy.Spider):
    name = 'books.toscrape.com'
    allowed_domains = ['books.toscrape.com']
    start_urls = ['http://books.toscrape.com/']

    def parse(self, response):
        for product in response.css('.product_pod'):
            url = product.css('.image_container a::attr(href)').get()
            if url:
                yield response.follow(url, self.get_book_information)
            #yield {'URL': url}
            # livro = self.get_book_information(response, url)

        urlN = response.css('.pager .next a::attr(href)').get()
        if urlN:
            yield response.follow(urlN)


    def get_book_information(self, response):
        nome = response.css('.thumbnail img::attr(alt)').get()
        preco = response.css('.price_color::text').get().replace('£','')
        estoque = response.xpath('//table[@class="table table-striped"]//td/text()')[5].get()
        disponivel = (estoque.find('In stock') >= 0)
        quantidade = re.findall(r'\d+', estoque)[0]
        ucp = response.xpath('//table[@class="table table-striped"]//td/text()')[0].get()
        categoria = response.xpath('//ul[@class="breadcrumb"]/li/a/text()')[2].get()
        avaliacao = response.css('.star-rating')[0].xpath("@class").extract()[0].replace('star-rating ', '')
        estrela = {'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5}
        print('Quantidade', quantidade)
        yield {'Livro': nome,
               'Preco': preco,
               'Disponivel': disponivel,
               'Quantidade': quantidade,
               'Avaliacao': estrela[avaliacao.lower()],
               'Categoria': categoria,
               'UCP': ucp}
