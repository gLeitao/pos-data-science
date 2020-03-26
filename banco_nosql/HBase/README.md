<h2>Exercicio 1 - Crie a tabela com 2 famílias de colunas</h2>
a) Crie a tabela com 2 famílias de colunas: 
personal-data
professional-data

    create'italians', 'personal-data', 'professional-data'

b) Importe o arquivo via linha de comando
  
    hbase shell /tmp/italians.txt

<h2>Exercicio 2 - Executando Comandos</h2>

a) Adicione mais 2 italianos mantendo adicionando informações como data de nascimento nas informações pessoais e um atributo de anos de experiência nas informações profissionais.

    put 'italians', '11', 'personal-data:name',  'Joseph Giorge'
    put 'italians', '11', 'personal-data:city',  'Florença'
    put 'italians', '11', 'personal-data:birthday',  '10/10/1984'
    put 'italians', '11', 'professional-data:role',  'Vendedor'
    put 'italians', '11', 'professional-data:salary',  '2700'
    put 'italians', '12', 'professional-data:experience',  '3'
    put 'italians', '12', 'personal-data:name',  'Maria Rosa'
    put 'italians', '12', 'personal-data:city',  'Milão'
    put 'italians', '12', 'personal-data:birthday',  '25/03/1972'
    put 'italians', '12', 'professional-data:role',  'Cozinheira'
    put 'italians', '12', 'professional-data:salary',  '1800'
    put 'italians', '12', 'professional-data:experience',  '4'

b) Adicione o controle de 5 versões na tabela de dados pessoais.

    alter 'italians', NAME => 'personal-data', VERSIONS => 5

c) Faça 5 alterações em um dos italianos.

    put 'italians', '11', 'personal-data:city',  'Bolonha'
    put 'italians', '11', 'personal-data:city',  'Verona'
    put 'italians', '11', 'personal-data:city',  'Pisa'
    put 'italians', '11', 'professional-data:salary',  '3000'
    put 'italians', '11', 'professional-data:salary',  '4000'

d) Com o operador get, verifique como o HBase armazenou o histórico.

    get 'italians', '11', {COLUMN => 'personal-data:city', VERSIONS => 5}

e) Utilize o scan para mostrar apenas o nome e profissão dos italianos.

    scan 'italians', {COLUMNS => ['personal-data:name', 'professional-data:role']}

f) Apague os italianos com row id ímpar.

    deleteall 'italians', ['1', '3', '5', '7', '9', '11']

g) Crie um contador de idade 55 para o italiano de row id 5.

    incr 'italians', '5', 'personal-data:age', 55

h) Incremente a idade do italiano em 1.

    incr 'italians', '5', 'personal-data:age'
