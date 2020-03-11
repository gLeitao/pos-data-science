import redis
r = redis.Redis(host='localhost', port=6379, db=0)

## usuarios que jogarão o bingo
for i in range(50):
    usuarios = 'usuario_'+str(i)
    r.hset(usuarios, 'nome', 'usuario_'+str(i))
    r.hset(usuarios, 'cartela', 'cartela_' + str(i))
    r.hset(usuarios, 'score', 'score_' + str(i))
    r.zadd('score', {'score_' + str(i): 0})


## criando a tabela gabarito para as cartelas
def create_gabarito():
    r.delete('numeros')
    for i in range(99):
        r.sadd('numeros', i)


## criando as tabelas para cada jogador
for i in range(50):
    for j in range(15):
        car = r.hget('usuario_' + str(i), 'cartela')
        create_gabarito()
        valor = int(r.srandmember('numeros'))
        r.sadd(car, valor)
        r.srem('numeros', valor)


## limpando o gabarito para o sorteio bingo
create_gabarito()

## fazendo o sorteio do bingo
ganhador = 0

while True:
    valor = int(r.srandmember('numeros'))

    for i in range(50):
        car = r.hget('usuario_' + str(i), 'cartela')
        score = r.hget('usuario_' + str(i), 'score')

        if r.sismember(car, valor):
            r.zincrby('score', float(1), score)
            r.srem('numeros', valor)
            if r.zscore('score', score) == float(15):
                ganhador = 1

    if ganhador == 1:
        break

print('Ganhador(es): ')
for i in range(len(r.zrange('score', 0, -1))):
    score = r.hget('usuario_' + str(i), 'score')
    for j in r.zrangebyscore('score', 15, 15):
        if score == j:
            print(' -', 'usuario_' + str(i))

