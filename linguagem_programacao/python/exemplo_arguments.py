from argparse import ArgumentParser

ag = ArgumentParser()

ag.add_argument('--a',
                type=int,
                required=True,
                help='Valor que sera utilizado na soma')

ag.add_argument('--b',
                type=int,
                required=True,
                help='Valor que sera utilizado na soma')

ag.add_argument('--operacao',
                type=str,
                required=False,
                default='adicao',
                help='operacao que deve ser realizada',
                choices=['adicao', 'subtracao', 'divisao', 'multiplicacao'])

operacoes = {
    'adicao': lambda a, b: a + b,
    'subtracao': lambda a, b: a - b,
    'divisao': lambda a, b: a / b,
    'multiplicacao': lambda a, b: a * b,
}

args = ag.parse_args()

fn = operacoes[args.operacao]

print(fn(args.a, args.b))

